import 'package:flutter/material.dart';

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
        child: ListView(
          children: <Widget>[
            Boxes(
              "Serpentes",
              AssetImage('images/serpentes.jpg'),
              (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Animais("Serpentes")
                  )
                );
              },
            ),
            Boxes(
              "Aranhas",
              AssetImage('images/aranhas.jpg'),
              (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Animais("Aranhas")
                  )
                );
              },
            ),
            Boxes(
              "Escorpiões",
              AssetImage('images/escorpioes.jpg'),
              (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Animais("Escorpiões")
                  )
                );
              },
            ),
            Boxes(
              "Marinhos",
              AssetImage('images/marinhos.jpg'),
              (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Animais("Marinhos")
                  )
                );
              },
            ),
          ],
        )
      ),
    );
  }
}