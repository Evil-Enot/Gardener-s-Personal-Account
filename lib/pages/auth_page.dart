// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;

import 'package:diploma/pages/main_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              _buildTitle(context),
              _buildNumberInput(context),
              _buildCodeInput(context),
              _buildCodeOverlay(context),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
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
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _buildNumberInput(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 5,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF9C0),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            keyboardType: TextInputType.phone,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF373737),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Введите номер телефона',
              hintStyle: TextStyle(
                color: Color(0xFF373737),
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeInput(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 5,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF9C0),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            keyboardType: TextInputType.text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF373737),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Код из смс',
              hintStyle: TextStyle(
                color: Color(0xFF373737),
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeOverlay(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        // onTap: _showOverlay(),
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          child: RichText(
            text: TextSpan(
              text: 'Не пришел код? ',
              style: TextStyle(
                color: Color(0xFF373737),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
                decoration: TextDecoration.underline,
              ),
              children: [
                TextSpan(
                  text: 'Отправить еще раз',
                  style: TextStyle(
                    color: Color(0xFF373737),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
      ),
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: const BoxDecoration(
        color: Color(0xFFFFED4D),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        },
        child: const Text(
          "Продолжить",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF373737),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
