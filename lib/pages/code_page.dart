import 'package:diploma/pages/main_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
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
    // final prefs = await SharedPreferences.getInstance();
    // final url = prefs.getString('url');
    // print(url);
    // Map<String, String> requestHeaders = {
    //   // 'Content-type': 'application/json',
    //   // 'Accept': 'application/json',
    //   'Authorization': 'Basic 0JLQtdGC0LrQuNC90LA6'
    // };
    // if (_bio.isNotEmpty && _number.isNotEmpty) {
    //   var response = await http.get(Uri.parse(url! + "/hs/diploma/check/number/info?bio="+_bio+"&number="+_number),
    //       headers: requestHeaders);
    //   if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
    //   } else {
    //     print('Request failed with status: ${response.statusCode}.');
    //   }
    // }
  }
}