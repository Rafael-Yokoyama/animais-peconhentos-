import 'package:flutter/material.dart';

import 'pages/Home.dart';

void main(){

  runApp(
    MaterialApp(
        theme: ThemeData(
           fontFamily: 'Raleway-Medium'
           //fontFamily: 'RobotoMono',


        ),
      debugShowCheckedModeBanner:  false,
      home: Home()
    )
  );
}