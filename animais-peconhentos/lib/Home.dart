import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Animais.dart';
import 'Boxes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "Animais peçonhentos",
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        child: StreamBuilder(
          stream: Firestore.instance.collection('categorias').snapshots(),
          builder: (context, snapshot){

            

            if(!snapshot.hasData) return const Text("Carregando...");

            return ListView.builder(
              //itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return Boxes(
                  snapshot.data.documents[index]["nome"],
                  //AssetImage('images/serpentes.jpg'),
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
      ),
    );
  }
}