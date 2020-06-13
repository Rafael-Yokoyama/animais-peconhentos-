import 'package:flutter/material.dart';

class ContatoDeEmergencia extends StatefulWidget {
  @override
  _ContatoDeEmergenciaState createState() => _ContatoDeEmergenciaState();
}

class _ContatoDeEmergenciaState extends State<ContatoDeEmergencia> {
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
      ),
    );
  }
}