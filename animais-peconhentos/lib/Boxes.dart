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
        bottom: 20
      ),

      child: GestureDetector(
        onTap: _funcao,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                //shape: BoxShape.circle,
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.3)),
                image: DecorationImage(
                  //image: this._image,
                  image: NetworkImage(_imgURL),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                this._nome,
                style: TextStyle(
                  fontSize: 25
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}