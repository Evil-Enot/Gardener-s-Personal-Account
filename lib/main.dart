import 'package:diploma/pages/auth_page.dart';
import 'package:diploma/pages/main_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  runApp(const DiplomaApp());
}

class DiplomaApp extends StatelessWidget {
  const DiplomaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Кабинет садовода",
      home: UrlPage(),
    );
  }
}

class UrlPage extends StatefulWidget {
  const UrlPage({Key? key}) : super(key: key);

  @override
  _UrlPageState createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  String _url = "";
  String _code = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitle(context),
              _buildURLInput(context),
              _buildCodeInput(context),
              _buildURLAndCodeOverlay(context),
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

  Widget _buildURLInput(BuildContext context) {
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
          maxLines: 1,
          textAlign: TextAlign.center,
          style: CustomTheme.textStyle20_400,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Введите URL сервера',
            hintStyle: CustomTheme.textStyle20_400,
          ),
          onChanged: (text) {
            _url = text.trim();
          },
          onSubmitted: (text) {
            FocusScope.of(context).requestFocus(nodeTwo);
          },
        ),
      ),
    );
  }

  Widget _buildCodeInput(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: CustomTheme.inputFieldsDecoration,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          focusNode: nodeTwo,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: CustomTheme.textStyle20_400,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Введите код авторизации',
            hintStyle: CustomTheme.textStyle20_400,
          ),
          onChanged: (text) {
            _code = text.trim();
          },
          scrollPadding: const EdgeInsets.only(bottom: 40),
        ),
      ),
    );
  }

  Widget _buildURLAndCodeOverlay(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Text(
            "Что такое URL и код авторизации?",
            textAlign: TextAlign.center,
            style: CustomTheme.textStyle14_400U,
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
          _checkURL();
        },
        child: Text(
          "Продолжить",
          textAlign: TextAlign.center,
          style: CustomTheme.textStyle20_400,
        ),
      ),
    );
  }

  _checkURL() async {
    final prefs = await SharedPreferences.getInstance();
    bool auth = false;

    if (_url.isNotEmpty && _code.isNotEmpty) {
      Map<String, String> requestHeaders = {'Authorization': 'Basic ' + _code};

      var response = await http.get(Uri.parse(_url + "/hs/diploma/check/url"),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        prefs.setString('url', _url);
        prefs.setString('auth_code', _code);

        if (prefs.containsKey('auth')) {
          auth = prefs.getBool('auth')!;
        }

        if (auth) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false,
          );
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AuthPage()));
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }
}
