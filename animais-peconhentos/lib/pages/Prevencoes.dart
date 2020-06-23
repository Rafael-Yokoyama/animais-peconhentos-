import 'package:flutter/material.dart';

class Prevencoes extends StatelessWidget {

  final Widget lista;

  Prevencoes(this.lista);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Prevenções".toUpperCase(),
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
              children: <Widget>[
                this.lista
              ]
            )
          )
        )
      ),
    );
  }
}