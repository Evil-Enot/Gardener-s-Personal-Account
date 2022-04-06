// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;

import 'package:diploma/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Widget _buildURLInput(BuildContext context) {
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
              hintText: 'Введите URL сервера',
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

  Widget _buildURLOverlay(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        // onTap: _showOverlay(),
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          child: const Text(
            "Что такое URL?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF373737),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
              decoration: TextDecoration.underline,
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
          _checkURL();
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

  _checkURL() async {
    // var url =
    //     Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    // var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonResponse =
    //       convert.jsonDecode(response.body) as Map<String, dynamic>;
    //   var itemCount = jsonResponse['totalItems'];
    //   print('Number of books about http: $itemCount.');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }
}
