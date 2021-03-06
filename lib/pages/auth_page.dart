import 'dart:convert';

import 'package:diploma/alert/alert_dialog.dart';
import 'package:diploma/models/auth_response.dart';
import 'package:diploma/pages/code_page.dart';
import 'package:diploma/pages/internet_connection_error_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitle(context),
              _buildBioInput(context),
              _buildNumberInput(context),
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
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
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
            hintStyle: CustomTheme.textStyleHint20_400,
          ),
          onChanged: (text) {
            _bio = text.trim();
          },
          onSubmitted: (text) {
            FocusScope.of(context).requestFocus(nodeTwo);
          },
        ),
      ),
    );
  }

  Widget _buildNumberInput(BuildContext context) {
    return Container(
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
          inputFormatters: [PhoneInputFormatter()],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Введите номер телефона',
            hintStyle: CustomTheme.textStyleHint20_400,
          ),
          onSubmitted: (text) {
            _number = text.replaceAll(RegExp(r'[ +\(\)\-]'), "").trim();
          },
          scrollPadding: const EdgeInsets.only(bottom: 40),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFFFED4D),
          shape: const StadiumBorder(),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
          ),
          side: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
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
    final authCode = prefs.getString('auth_code');

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    bool result = await InternetConnectionChecker().hasConnection;

    if (_bio.isNotEmpty && _number.isNotEmpty) {
      if (result == true) {
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
          AuthResponse responseAuth =
              AuthResponse.fromJson(jsonDecode(response.body));
          prefs.setString("bio", _bio);
          prefs.setInt("code", responseAuth.code);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CodePage()));
        } else {
          if (response.statusCode == 404) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogBuilder().printAlertDialog(
                    context, 'Пользователь с таким ФИО не обнаружен');
              },
            );
          } else if (response.statusCode == 403) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogBuilder().printAlertDialog(context,
                    'Введенный номер телефона не совпадает с номером телефона в базе данных');
              },
            );
          } else if (response.statusCode == 400) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogBuilder().printAlertDialog(context,
                    'Не удалось отправить код для авторизации на указаный номер телефона. Обратитесь к администратору для устранения неисправности');
              },
            );
          }
        }
      } else {
        prefs.setString("last_page", "/auth");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const InternetConnectionError(),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogBuilder().printAlertDialog(context,
              'Обязательные поля "ФИО" и "Номер телефона" не заполнены');
        },
      );
    }
  }
}
