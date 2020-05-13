
import 'package:flutter/material.dart';

import 'Boxes.dart';
import 'Detalhes.dart';

class Animais extends StatelessWidget {

  final String _nome;
  ListView _lista;
  BuildContext _context;

  Animais(this._nome){

    if(this._nome=="Serpentes"){
      _lista = ListView(
        children: <Widget>[
          Boxes(
            "Jiboia-arco-íris",
            AssetImage('images/jiboia-arco-iris.jpg'),
            (){
              Navigator.push(
                this._context,
                MaterialPageRoute(
                  builder: (context) => Detalhes(
                    "Jiboia-arco-íris",
                    "Serpentes",
                    AssetImage('images/jiboia-arco-iris.jpg'),
                    [
                      "90% dos acidentes ofídicios registrados no país. Agressiva",
                      
                      "Habitat da Jararaca:",
                      "zonas rurais e periferias de grandes cidades,",
                      "ambientes úmidos (matas e áreas cultivadas)",
                      "locais de proliferação de roedores (paióis, celeiros, depósitos de lenha)",
                    ],
                    [
                      "Dor",
                      "Inchaço, bolhas e sangramento no local da picada.",
                      "Sangramentos em ferimentos pré-existentes, (exemplo na gengiva, nariz e na urina).",
                      "Náuseas, vômitos, sudorese.",
                      "Diminuição da pressão arterial.",
                      "Em gestantes há risco de hemorragia uterina.",
                    ],
                    [
                      "Manter jardins e quintais limpos",
                      "Não pôr as mãos em buracos, sob pedras e troncos podres.",
                      "Usar calçados e luvas de raspas de couro.",
                      "Vedar frestas e buracos em paredes, assoalhos e vãos entre o forro e paredes, consertar rodapés despregados, colocar saquinhos de areia nas portas, colocar telas nas janelas.",
                    ]
                  )
                )
              );
            }
          ),
          Boxes(
            "Jararaca",
            AssetImage('images/jararaca.jpg'),
            (){
              Navigator.push(
                this._context,
                MaterialPageRoute(
                  builder: (context) => Detalhes(
                    "Jararaca",
                    "Serpentes",
                    AssetImage('images/jararaca.jpg'),
                    [
                      "8% dos acidentes ofídicos",
                      "quando ameaçada emite ruído do guizo",

                      "Habitat da Cascavel",
                      "Campos abertos, áreas secas, arenosas ou pedregosas, pouca resistência em ambientes úmidos.",
                      "Não ocorrem em florestas (amazônica), no Pantanal e litoral."
                    ],
                    [
                      "Dor",
                      "Inchaço, bolhas e sangramento no local da picada.",
                      "Sangramentos em ferimentos pré-existentes, (exemplo na gengiva, nariz e na urina).",
                      "Náuseas, vômitos, sudorese.",
                      "Diminuição da pressão arterial.",
                      "Em gestantes há risco de hemorragia uterina.",
                    ],
                    [
                      "Manter jardins e quintais limpos",
                      "Não pôr as mãos em buracos, sob pedras e troncos podres.",
                      "Usar calçados e luvas de raspas de couro.",
                      "Vedar frestas e buracos em paredes, assoalhos e vãos entre o forro e paredes, consertar rodapés despregados, colocar saquinhos de areia nas portas, colocar telas nas janelas.",
                    ]
                  )
                )
              );
            }
          ),
          Boxes(
            "Cascavel",
            AssetImage('images/cascavel.jpg'),
            () {}
          ),
          Boxes(
            "Sururucu",
            AssetImage('images/sururucu.jpg'),
            () {}
          ),
          Boxes(
            "Coral",
            AssetImage('images/coral.jpg'),
            () {}
          ),
          
        ],
      );
    } else if (this._nome == "Aranhas"){
      _lista = ListView(
        children: <Widget>[
          Boxes(
            "Viúva negra",
            AssetImage('images/viuva-negra.jpg'),
            () {}
          ),
          Boxes(
            "Armadeira",
            AssetImage('images/Armadeira.jpg'),
            () {}
          ),
          Boxes(
            "Aranha vespa",
            AssetImage('images/Aranha-Vespa.jpg'),
            () {}
          ),
          
        ],
      );
    } else if (this._nome == "Escorpiões"){
      _lista = ListView(
        children: <Widget>[
          Boxes(
            "Escorpião amarelo",
            AssetImage('images/Escorpiao-amarelo.jpg'),
            () {}
          ),
          Boxes(
            "Escorpião preto",
            AssetImage('images/Escorpiao-preto.jpg'),
            () {}
          ),
          Boxes(
            "Escorpião do nordeste",
            AssetImage('images/Escorpiao-do-nordeste.jpg'),
            () {}
          ),
          
        ],
      );
    } else if (this._nome == "Marinhos"){
      _lista = ListView(
        children: <Widget>[
          Boxes(
            "Conus",
            AssetImage('images/CONUS.jpg'),
            () {}
          ),
          Boxes(
            "Raia manteiga",
            AssetImage('images/RAIA-MANTEIGA.jpg'),
            () {}
          ),
          Boxes(
            "Ouriço do mar",
            AssetImage('images/OURIÇO-DO-MAR.jpg'),
            () {}
          ),
        ],
      );
    } else {
      _lista = ListView(

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "Lista de $_nome",
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        child: _lista
      ),
    );
  }
}