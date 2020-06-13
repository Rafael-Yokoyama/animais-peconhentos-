import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ContatoDeEmergencia extends StatefulWidget {

  final String idUsuario;

  ContatoDeEmergencia(this.idUsuario);

  @override
  _ContatoDeEmergenciaState createState() => _ContatoDeEmergenciaState();
}

class _ContatoDeEmergenciaState extends State<ContatoDeEmergencia> {

  Future<dynamic> getContatoAtual() async{

    DocumentSnapshot _dadosUsuario = await Firestore.instance
      .collection('usuarios').document(widget.idUsuario).get();
    
    return _dadosUsuario.data['contatoDeEmergencia'];
  }

  void initState(){
    super.initState();

    getContatoAtual().then(
      (value){
        setState(() {
          _controllerContato.text = value.toString();
        });
      }
    ).catchError(
      (error) => print (error)
    );
  }

  void salvarContato() async{
    await Firestore.instance.collection("usuarios").document(widget.idUsuario).updateData({
      "contatoDeEmergencia" : _controllerContato.text
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text("Contato de emergência atualizado"),
        actions: <Widget>[
          FlatButton(
            child: Text("Fechar"),
            onPressed:(){
              Navigator.pop(context); //fecha o alert
              Navigator.pop(context); //fecha a tela
            },
          )
        ],
      )
    );

  }

  TextEditingController _controllerContato = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Contato de emergência".toUpperCase(),
            style: TextStyle(
              color: Color(0xFFaebb25)
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/fundo.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Digite o contato de emegência",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  //cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      ),
                    ),
                    /*
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                        
                      )
                    ),
                    */
                    labelText: "Contato",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                  controller: _controllerContato,
                  onSubmitted: (String value) => salvarContato(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    onPressed: salvarContato,
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      "Salvar contato",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ]
            )
          )
        )
      ),
    );
  }
}