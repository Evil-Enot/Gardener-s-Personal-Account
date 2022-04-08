import 'package:diploma/pages/auth_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
  String _url = "";
  bool _isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              _buildTitle(context),
              _buildURLInput(context),
              _buildURLOverlay(context),
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
            maxLines: 1,
            textAlign: TextAlign.center,
            style: CustomTheme.textStyle20_400,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Введите URL сервера',
              hintStyle: CustomTheme.textStyle20_400,
            ),
            onSubmitted: (text) {
              _url = text;
              print(text);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildURLOverlay(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        // onTap: _showOverlay(),
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Text(
            "Что такое URL?",
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
    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Basic 0JLQtdGC0LrQuNC90LA6'
    };
    if (_url.isNotEmpty) {
      var response = await http.get(Uri.parse(_url + "/hs/diploma/check/url"),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AuthPage()));
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } else {
      _isEmpty = true;
    }
  }
}
