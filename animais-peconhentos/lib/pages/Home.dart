import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:location/location.dart';

import 'Animais.dart';
import 'Boxes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  dynamic _idUsuario;

  _HomeState(){
    _idUsuario = null;
  }

  Future<Map> _getPreferencias() async{
    final prefs = await SharedPreferences.getInstance();

    dynamic idUsuario = prefs.getString('idUsuario');

    Map retornar = {'idUsuario': idUsuario};
    
    return retornar;

  }

  Future<String> signInWithGoogle() async {

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    //print(user.displayName);
    //print(user.email);

    //verificar se existe o email no banco
    //se não houver, salva e pega o novo id

    //se houver apenas retorna o id
    String idUsuario = "";

    QuerySnapshot _buscarUsuario = await Firestore.instance
      .collection('usuarios')
      .where(
        'email',
        isEqualTo: user.email,
      )
      .getDocuments();
    
    if(_buscarUsuario.documents.length > 0){
      idUsuario = _buscarUsuario.documents[0].documentID;
    } else {
      DocumentReference _refDoc = await Firestore.instance.collection("usuarios").add(
        {
          'nome': user.displayName,
          'email': user.email,
          'localizacao' :
          {
            'latitude': 0,
            'longitude': 0,
          }
        }
      );

      idUsuario = _refDoc.documentID;

    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idUsuario', idUsuario);

    setState(() {
      this._idUsuario = idUsuario;
    });

  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('idUsuario', null);

    setState(() {
      _idUsuario = null;
    });

  }

  Widget _gerarTela(){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/fundo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(top: 16),
      child: StreamBuilder(
        stream: Firestore.instance.collection('categorias').snapshots(),
        builder: (context, snapshot){

          

          if(!snapshot.hasData) return const Text("Carregando...");

          return GridView.builder(
            //itemExtent: 80,
            itemCount: snapshot.data.documents.length,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              //crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0
            ),
            itemBuilder: (context, index){
              return Boxes(
                snapshot.data.documents[index]["nome"],
                snapshot.data.documents[index]["imagem"],
                (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return Animais(
                          snapshot.data.documents[index]["nome"],
                          snapshot.data.documents[index].documentID
                        );
                      }
                    )
                  );
                },
              );
            }
          );
        }
      ),
    );
  }

  Widget _signInButton(){
    return FlatButton(
      splashColor: Colors.grey,
      onPressed: (){
          signInWithGoogle();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Conectar com Google',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _gerarRodape(){
    if(_idUsuario==null){
      return _signInButton();
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () async{

              Location location = new Location();

              bool _serviceEnabled;
              PermissionStatus _permissionGranted;
              LocationData _locationData;

              _serviceEnabled = await location.serviceEnabled();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  return;
                }
              }

              _permissionGranted = await location.hasPermission();
              if (_permissionGranted == PermissionStatus.denied) {
                _permissionGranted = await location.requestPermission();
                if (_permissionGranted != PermissionStatus.granted) {
                  return;
                }
              }

              _locationData = await location.getLocation();

              await Firestore.instance.collection("usuarios").document(_idUsuario).updateData({
                "localizacao" :
                {
                  'latitude': _locationData.latitude,
                  'longitude': _locationData.longitude,
                }
              });
              
            },
            child: Text(
              "Chamada de emergência",
              style: TextStyle(
                color: Colors.red
              ),
            )
          ),
          FlatButton(
            onPressed: () {
              signOutGoogle();
              //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
            },
            //color: Colors.deepPurple,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Deslogar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );
    }
  }

  void initState(){
    super.initState();

    Future<Map> preferencias = _getPreferencias();

    preferencias.then(
      (value) {
        setState(() {
          this._idUsuario = value['idUsuario'];
        });
      }
    ).catchError(
      (error) => print (error)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Animais peçonhentos".toUpperCase(),
            style: TextStyle(
              color: Color(0xFFaebb25)
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: _gerarTela(),
      ),      
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: _gerarRodape()
      )
    );
  }
}