import 'package:flutter/material.dart';

class Detalhes extends StatefulWidget {

  String _nome;
  String _categoria;
  String _image;
  List<dynamic> _caracteristicas;
  List<dynamic> _sintomas;
  List<dynamic> _prevencoes;

  Detalhes(this._nome, this._categoria, this._image, this._caracteristicas, this._sintomas, this._prevencoes);

  @override
  _DetalhesState createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {

  Widget mostrarCaracteristicas(){

    if(widget._caracteristicas.length>0){

      List<Widget> lista = List();

      for(int i = 0; i < widget._caracteristicas.length; i++){

        lista.add(
          Text(
            " - "+widget._caracteristicas[i],
            style: TextStyle(
              fontSize: 20
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

  Widget mostrarSintomas(){

    if(widget._caracteristicas.length>0){
      List<Widget> lista = List();

      for(int i = 0; i < widget._sintomas.length; i++){

        lista.add(
          Text(" - "+widget._sintomas[i])
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
          Text(" - "+widget._prevencoes[i])
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            widget._nome,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image(
                image: NetworkImage(widget._image),
              ),
              mostrarCaracteristicas(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  widget._sintomas.length > 0 ?(
                    RaisedButton(
                      child: Text("Sintomas", style: TextStyle(fontSize: 20),),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // retorna um objeto do tipo Dialog
                            return AlertDialog(
                              title: new Text("Sintomas"),
                              content: mostrarSintomas(),
                              actions: <Widget>[
                                // define os botões na base do dialogo
                                new FlatButton(
                                  child: new Text("Fechar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    )
                  ) : Text(""),
                  widget._prevencoes.length > 0 ? (
                    RaisedButton(
                      child: Text("Prevenções", style: TextStyle(fontSize: 20),),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // retorna um objeto do tipo Dialog
                            return AlertDialog(
                              title: new Text("Prevenções"),
                              content: mostrarPrevencoes(),
                              actions: <Widget>[
                                // define os botões na base do dialogo
                                new FlatButton(
                                  child: new Text("Fechar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    )
                  ) : Text(""),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}