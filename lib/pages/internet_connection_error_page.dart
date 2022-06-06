import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
          child: Container(
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
                    onPressed: () async {
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
          ),
        ),
      ),
    );
  }

  Future<void> _checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    final prefs = await SharedPreferences.getInstance();
    final lastPage = prefs.getString('last_page');
    print(lastPage);

    if (result == true) {
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
                    // Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                    Navigator.pushNamed(context, lastPage!);
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Подключение к интернету не обнаружено",
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


