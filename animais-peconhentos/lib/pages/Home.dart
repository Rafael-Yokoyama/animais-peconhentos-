import 'package:aula_2020_03_24/pages/ContatoDeEmergencia.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Animais.dart';
import 'Boxes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  //final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  dynamic _idUsuario;

  _HomeState(){
    _idUsuario = null;
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Map> _getPreferencias() async{
    final prefs = await SharedPreferences.getInstance();

    dynamic idUsuario = prefs.getString('idUsuario');

    Map retornar = {'idUsuario': idUsuario};
    
    return retornar;
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

  void signInWithGoogle() async {

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
          'localizacao' : { },
          'contatoDeEmergencia' : ''
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

  Future<dynamic> getContatoAtual() async{

    DocumentSnapshot _dadosUsuario = await Firestore.instance
      .collection('usuarios').document(this._idUsuario).get();
    
    return _dadosUsuario.data['contatoDeEmergencia'];
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

  Widget _gerarRodape(){
    if(_idUsuario==null){
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

              getContatoAtual().then(
                (value){
                  _makePhoneCall("tel:$value").then(
                    (value) => null
                  ).catchError(
                    (error) => print (error)
                  );
                  //print("chamar: "+value);
                }
              ).catchError(
                (error) => print (error)
              );
              
            },
            child: Text(
              "Chamada de emergência",
              style: TextStyle(
                color: Colors.red
              ),
            )
          ),
        ],
      );
    }
  }

  Widget _gerarCabecalho(){

    List<Widget> actions = List();

    if(_idUsuario!=null){
      actions.add(
        PopupMenuButton(
          onSelected: opcaoMenuSelecionada,
          itemBuilder: (BuildContext context) {
            return OpcoesMenu.opcoes.map((String choice) {
              return PopupMenuItem(
                value: choice,
                child: Text(choice)
              );
            }).toList();
          }
        )
      );
    }

    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: Text(
        "Animais peçonhentos".toUpperCase(),
        style: TextStyle(
          color: Color(0xFFaebb25)
        ),
      ),
      actions: actions,
    );
  }

  void opcaoMenuSelecionada(String choice){
    if(choice == OpcoesMenu.ContatoDeEmergencia){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context){
            return ContatoDeEmergencia(this._idUsuario);
          }
        )
      );
    } else if(choice == OpcoesMenu.Deslogar) {
      signOutGoogle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _gerarCabecalho(),
        body: _gerarTela(),      
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: _gerarRodape()
        )
      ),
    );
  }
}

class OpcoesMenu{

  static const String ContatoDeEmergencia = "Contato de emergência";
  static const String Deslogar = "Deslogar";

  static const List<String> opcoes = <String>[
    ContatoDeEmergencia,
    Deslogar
  ];

}