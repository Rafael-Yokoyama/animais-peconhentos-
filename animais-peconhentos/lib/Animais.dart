
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Boxes.dart';
import 'Detalhes.dart';

class Animais extends StatefulWidget {

  final String _nome;
  final String _categoriaId;

  Animais(this._nome, this._categoriaId){
  }

  @override
  _AnimaisState createState() => _AnimaisState();
}

class _AnimaisState extends State<Animais> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "Lista de ${widget._nome}",
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        child: StreamBuilder(
          stream: Firestore.instance.collection('categorias').document(widget._categoriaId).collection('animais').snapshots(),
          builder: (context, snapshot){

            

            if(!snapshot.hasData) return const Text("Carregando...");

            return ListView.builder(
              //itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return Boxes(
                  snapshot.data.documents[index]["nome"],
                  snapshot.data.documents[index]["imagem"],
                  //AssetImage('images/jiboia-arco-iris.jpg'),
                  (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return Detalhes(
                            snapshot.data.documents[index]["nome"],
                            widget._nome,
                            snapshot.data.documents[index]["imagem"],
                            //AssetImage('images/jiboia-arco-iris.jpg'),
                            snapshot.data.documents[index]["caracteristicas"],
                            snapshot.data.documents[index]["sintomas"],
                            snapshot.data.documents[index]["prevencoes"]
                          );
                        }
                      )
                    );
                  }
                );
              }
            );
          }
        ),
      ),
    );
  }
}