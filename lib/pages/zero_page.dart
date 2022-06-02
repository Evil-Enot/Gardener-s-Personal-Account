import 'package:diploma/pages/login_page.dart';
import 'package:diploma/pages/url_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZeroPage extends StatefulWidget {
  const ZeroPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZeroPageState();
}

class _ZeroPageState extends State<ZeroPage> {
  @override
  void initState() {
    _checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color(0xFFFFF9C0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "Личный кабинет садовода",
                    textAlign: TextAlign.center,
                    style: CustomTheme.textStyle50_400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    bool auth = false;

    if (prefs.containsKey('auth')) {
      auth = prefs.getBool('auth')!;
    }

    if (auth) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const UrlPage()));
    }
  }
}
