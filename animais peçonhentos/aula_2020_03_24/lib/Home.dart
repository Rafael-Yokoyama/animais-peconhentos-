import 'package:flutter/material.dart';

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
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05
                ),

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
                          image: AssetImage('images/serpentes.jpg'),
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
                        "Serpentes",
                        style: TextStyle(
                          fontSize: 25
                        ),
                      ),
                    )
                  ],
                )
              ),
              
            ],
          )
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  )
                )
              ],
            )
          )
        ),
      );
  }
}