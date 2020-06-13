import 'Sintomas.dart';
import 'Prevencoes.dart';
import 'package:flutter/material.dart';

class Detalhes extends StatefulWidget {

  String _nome;
  String _categoria;
  Map<String, dynamic> _caracteristicas;
  List<dynamic> _sintomas;
  List<dynamic> _prevencoes;

  Detalhes(this._nome, this._categoria, this._caracteristicas, this._sintomas, this._prevencoes);

  @override
  _DetalhesState createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {

  Widget mostrarCaracteristicas(){

    if(widget._caracteristicas.length>0){

      List<Widget> lista = List();

      if(widget._caracteristicas.containsKey('imagens')){
        for(int i = 0; i < widget._caracteristicas['imagens'].length; i++){

          lista.add(
            Image(
              image: NetworkImage(widget._caracteristicas['imagens'][i]),
            ),
          );
        }
      }
      if(widget._caracteristicas.containsKey('texto')){
        for(int i = 0; i < widget._caracteristicas['texto'].length; i++){

          lista.add(
            Text(
              " - "+widget._caracteristicas['texto'][i],
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFFFFFF)
              ),
            )
          );

        }
      }

      return Column(
        children: lista,
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    } else {

      return Text("");
    }
  }

  Widget mostrarSintomas(){

    if(widget._caracteristicas.length>0){
      List<Widget> lista = List();

      for(int i = 0; i < widget._sintomas.length; i++){

        lista.add(
          Text(
            " - "+widget._sintomas[i],
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFFFFFF)
            ),
          )
        );

      }

      return Column(
        children: lista,
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    } else {
      return Text("");
    }
  }

  Widget mostrarPrevencoes(){

    if(widget._caracteristicas.length>0){
      List<Widget> lista = List();

      for(int i = 0; i < widget._prevencoes.length; i++){

        lista.add(
          Text(
            " - "+widget._prevencoes[i],
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFFFFFF)
            ),
          )
        );

      }

      return Column(
        children: lista,
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    } else {
      return Text("");
    }
  }

  Widget _gerarTela(){
    return Container(
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
            mostrarCaracteristicas(),
          ],
        ),
      )
    );
  }

  BottomAppBar _gerarRodape(){
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget._sintomas.length > 0 ?(
            FlatButton(
              child: Text(
                "Sintomas",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
              onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return Sintomas(
                        mostrarSintomas()
                      );
                    }
                  )
                );
              }
            )
          ) : Text(""),
          widget._prevencoes.length > 0 ?(
            FlatButton(
              child: Text(
                "Prevenções",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return Prevencoes(
                        mostrarPrevencoes()
                      );
                    }
                  )
                );
              }
            )
          ) : Text(""),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            widget._nome.toUpperCase(),
            style: TextStyle(
              color: Color(0xFFaebb25)
            ),
          ),
        ),
        body: _gerarTela(),
        bottomNavigationBar: _gerarRodape()
      ),
    );
  }
}