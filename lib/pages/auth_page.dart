import 'dart:convert';

import 'package:diploma/pages/code_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  String _bio = "";
  String _number = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              _buildTitle(context),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _buildBioInput(context),
                  _buildNumberInput(context),
                ],
              ),
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
      decoration: CustomTheme.headerDecoration,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(
          "Личный кабинет садовода",
          textAlign: TextAlign.center,
          style: CustomTheme.textStyle50_400,
        ),
      ),
    );
  }

  Widget _buildBioInput(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.02,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: CustomTheme.inputFieldsDecoration,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: TextField(
            keyboardType: TextInputType.text,
            focusNode: nodeOne,
            textCapitalization: TextCapitalization.words,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: CustomTheme.textStyle20_400,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Введите ФИО',
              hintStyle: CustomTheme.textStyle20_400,
            ),
            onSubmitted: (text) {
              print(text);
              _bio = text.trim();
              FocusScope.of(context).requestFocus(nodeTwo);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNumberInput(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: CustomTheme.inputFieldsDecoration,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: TextField(
            keyboardType: TextInputType.phone,
            focusNode: nodeTwo,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: CustomTheme.textStyle20_400,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Введите номер телефона',
              hintStyle: CustomTheme.textStyle20_400,
            ),
            onSubmitted: (text) {
              print(text);
              _number = text.trim();
            },
            scrollPadding: EdgeInsets.only(bottom: 40),
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
      decoration: CustomTheme.buttonsDecoration,
      child: TextButton(
        onPressed: () {
          _checkAuth();
        },
        child: Text(
          "Продолжить",
          textAlign: TextAlign.center,
          style: CustomTheme.textStyle20_400,
        ),
      ),
    );
  }

  _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic 0JLQtdGC0LrQuNC90LA6'
    };
    if (_bio.isNotEmpty && _number.isNotEmpty) {
      var response = await http.post(
        Uri.parse(url! + "/hs/diploma/check/number"),
        headers: requestHeaders,
        body: jsonEncode(
          <String, String>{
            'bio': _bio,
            'number': _number,
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CodePage()));
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }
}
