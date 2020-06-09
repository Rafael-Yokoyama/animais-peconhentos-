
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Boxes.dart';
import 'Detalhes.dart';

class Animais extends StatefulWidget {

  final String _nome;
  final String _categoriaId;

  Animais(this._nome, this._categoriaId);

  @override
  _AnimaisState createState() => _AnimaisState();
}

class _AnimaisState extends State<Animais> {

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
        stream: Firestore.instance.collection('categorias').document(widget._categoriaId).collection('animais').snapshots(),
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
                        return Detalhes(
                          snapshot.data.documents[index]["nome"],
                          widget._nome,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Lista de ${widget._nome}".toUpperCase(),
            style: TextStyle(
              color: Color(0xFFaebb25)
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: _gerarTela()
      )
    );
  }
}