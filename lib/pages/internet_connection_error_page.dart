import 'package:diploma/pages/main_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InternetConnectionError extends StatefulWidget {
  const InternetConnectionError({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InternetConnectionErrorState();
}

class _InternetConnectionErrorState extends State<InternetConnectionError> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _buildMainContent(context),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/internet_error.svg',
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Text(
              'Отсутствует соединение с интернетом',
              style: CustomTheme.textStyle36_400,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFF6969),
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
                _checkInternet();
              },
              child: Text(
                "Повторить",
                textAlign: TextAlign.center,
                style: CustomTheme.textStyle20_400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkInternet() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final authCode = prefs.getString('auth_code');

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    try {
      var response = await http.get(Uri.parse(url! + "/hs/diploma/check/url"),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Подключение к интернету восстановлено",
                style: CustomTheme.textStyle20_400,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
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
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Закрыть',
                      textAlign: TextAlign.center,
                      style: CustomTheme.textStyle20_400,
                    ),
                  ),
                )
              ],
            );
          },
        );
      }
    } catch (e) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Подключение к интернету не обнаружено',
              style: CustomTheme.textStyle20_400,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6969),
                    shape: const StadiumBorder(),
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.08,
                      right: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Закрыть',
                    textAlign: TextAlign.center,
                    style: CustomTheme.textStyle20_400,
                  ),
                ),
              )
            ],
          );
        },
      );
    }
  }
}
