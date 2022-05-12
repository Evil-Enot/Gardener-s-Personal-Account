import 'package:diploma/pages/main_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
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
            keyboardType: TextInputType.text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: CustomTheme.textStyle20_400,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Код из смс',
              hintStyle: CustomTheme.textStyle20_400,
            ),
            onSubmitted: (text) {
              print(text);
              _code = text.trim();
            },
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
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.01,
          ),
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

    if (prefs.containsKey("code")) {
      final code = prefs.getInt("code").toString();

      if (_code == code) {
        prefs.setBool("auth", true);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        print("different codes");
      }
    } else {
      print("code not saved");
    }
  }
}
