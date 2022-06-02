import 'dart:convert';

import 'package:diploma/alert/alert_dialog.dart';
import 'package:diploma/models/auth_response.dart';
import 'package:diploma/pages/internet_connection_error_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LocalAuthentication auth = LocalAuthentication();

  String _code = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: _checkBiometrics(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  _buildTitle(context),
                  _authWithCode(context),
                  if (snapshot.data!) _authWithBioTitle(context),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
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

  _authWithBioTitle(BuildContext context) {
    _authWithBio(context);
    return const Text("");
  }

  _authWithBio(BuildContext context) async {
    bool authenticate = false;
    try {
      authenticate = await auth.authenticate(
        localizedReason: "Scan your finger to auth",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      if (authenticate) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
          (route) => false,
        );
      }
    } on PlatformException {
      rethrow;
    }
  }

  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;

      return canCheckBiometrics;
    } on PlatformException {
      rethrow;
    }
  }

  Widget _authWithCode(BuildContext context) {
    return Column(
      children: [
        Container(
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
                hintText: 'Введите код из смс',
                hintStyle: CustomTheme.textStyleHint20_400,
              ),
              onSubmitted: (text) {
                _code = text.trim();
              },
            ),
          ),
        ),
        Container(
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
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01,
          ),
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
              _sendCode();
            },
            child: Text(
              "Продолжить",
              textAlign: TextAlign.center,
              style: CustomTheme.textStyle20_400,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _sendCode() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final bio = prefs.getString('bio');
    final authCode = prefs.getString('auth_code');

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
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
        if (_code == responseAuth.code.toString()) {
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
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const InternetConnectionError(),
        ),
      );
    }
  }
}
