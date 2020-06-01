import 'package:flutter/material.dart';

class Boxes extends StatelessWidget {

  //final Image _image;
  final String _imgURL;
  final String _nome;
  final Function _funcao;

  Boxes(
    this._nome,
    this._imgURL,
    this._funcao
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05
      ),
      margin: EdgeInsets.only(
        //bottom: 20
      ),

      child: GestureDetector(
        onTap: _funcao,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                //shape: BoxShape.circle,
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.4)),
                image: DecorationImage(
                  //image: this._image,
                  image: NetworkImage(_imgURL),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              this._nome,
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ],
        ),
      )
    );
  }
}