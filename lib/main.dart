import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(DiplomaApp());

class DiplomaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Кабинет садовода",
      home: UrlPage(),
    );
  }
}

class UrlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF9C0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "Личный кабинет садовода",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF373737),
                          fontSize: 50,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF9C0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Введите URL сервера',
                          hintStyle: TextStyle(
                              color: Color(0xFF373737),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
