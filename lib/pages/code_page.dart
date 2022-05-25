import 'dart:convert';

import 'package:diploma/models/auth_response.dart';
import 'package:diploma/pages/alert_dialog.dart';
import 'package:diploma/pages/main_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  String _code = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              _buildTitle(context),
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

  Widget _buildCodeInput(BuildContext context) {
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
          keyboardType: TextInputType.number,
          maxLines: 1,
          // maxLength: 6,
          textAlign: TextAlign.center,
          style: CustomTheme.textStyle20_400,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Код из смс',
            hintStyle: CustomTheme.textStyleHint20_400,
          ),
          onSubmitted: (text) {
            _code = text.trim();
          },
        ),
      ),
    );
  }

  Widget _buildCodeOverlay(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        child: TextButton(
          onPressed: () {
            _sendCode();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogBuilder()
                    .printAlertDialog(context, 'Код отправлен заново');
              },
            );
          },
          child: RichText(
            text: TextSpan(
              text: 'Не пришел код? ',
              style: CustomTheme.textStyle14_400U,
              children: [
                TextSpan(
                  text: 'Отправить еще раз',
                  style: CustomTheme.textStyle14_700U,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return TextButton(
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
        _checkCode();
      },
      child: Text(
        "Продолжить",
        textAlign: TextAlign.center,
        style: CustomTheme.textStyle20_400,
      ),
    );
  }

  _checkCode() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("code")) {
      final code = prefs.getInt("code").toString();

      if (_code == code) {
        prefs.setBool("auth", true);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
          (route) => false,
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialogBuilder()
                .printAlertDialog(context, 'Неверный код авторизации');
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogBuilder().printAlertDialog(
              context, 'Проблема с авторизацией, перезапустите приложение');
        },
      );
    }
  }

  Future<void> _sendCode() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final bio = prefs.getString('bio');
    final authCode = prefs.getString('auth_code');
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    var response = await http.post(
      Uri.parse(url! + "/hs/diploma/get/code"),
      headers: requestHeaders,
      body: jsonEncode(
        <String, String>{
          'bio': bio!,
        },
      ),
    );
    if (response.statusCode == 200) {
      AuthResponse responseAuth =
          AuthResponse.fromJson(jsonDecode(response.body));
      prefs.setInt("code", responseAuth.code);
    } else {
      if (response.statusCode == 400) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialogBuilder().printAlertDialog(context,
                'Не удалось отправить код для авторизации на указаный номер телефона. Обратитесь к администратору для устранения неисправности');
          },
        );
      }
    }
  }
}
