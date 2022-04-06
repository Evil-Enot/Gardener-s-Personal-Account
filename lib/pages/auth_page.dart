import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: const Text(
                  "Личный кабинет садовода",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(-13158601),
                      fontSize: 50,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }

}