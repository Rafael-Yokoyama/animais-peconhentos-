import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Animais peçonhentos",
            style: TextStyle(
              color: Color(0xFFaebb25)
            ),
          ),
        ),
      ),
      body: Container(
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(onPressed: null,
              child: Text(
                "Chamada de emergência",
                style: TextStyle(
                  color: Colors.red
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}