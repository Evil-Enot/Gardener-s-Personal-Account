import 'package:diploma/alert/alert_dialog.dart';
import 'package:diploma/notifications/notification_service.dart';
import 'package:diploma/pages/auth_page.dart';
import 'package:diploma/pages/bills_page.dart';
import 'package:diploma/pages/info_page.dart';
import 'package:diploma/pages/internet_connection_error_page.dart';
import 'package:diploma/pages/main_page.dart';
import 'package:diploma/pages/meters_page.dart';
import 'package:diploma/pages/payment_page.dart';
import 'package:diploma/pages/settings_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  NotificationService().init();
  await GetStorage.init('Storage');
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const UrlPage(),
        '/auth': (context) => const AuthPage(),
        '/main': (context) => const MainPage(),
        '/info': (context) => const InfoPage(),
        '/bills': (context) => const BillsPage(),
        '/meters': (context) => const MetersPage(),
        '/settings': (context) => const SettingsPage(),
        '/payment': (context) => const PaymentPage(),
      },
      title: "Кабинет садовода",
    ),
  );
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
            hintStyle: CustomTheme.textStyleHint20_400,
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
            hintStyle: CustomTheme.textStyleHint20_400,
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
        child: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogBuilder().printAlertDialog(context,
                    'URL - адрес, по которому происходит связь с сервером 1С.\nURL можно получить, обратившись к председателю  вашего садоводства.');
              },
            );
          },
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
        _checkURL();
      },
      child: Text(
        "Продолжить",
        textAlign: TextAlign.center,
        style: CustomTheme.textStyle20_400,
      ),
    );
  }

  _checkURL() async {
    final prefs = await SharedPreferences.getInstance();

    bool auth = false;
    bool result = await InternetConnectionChecker().hasConnection;

    if (_url.isNotEmpty && _code.isNotEmpty) {
      Map<String, String> requestHeaders = {'Authorization': 'Basic ' + _code};

      if (result == true) {
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
          if (response.statusCode == 401) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogBuilder()
                    .printAlertDialog(context, 'Неверный код авторизации');
              },
            );
          } else if (response.statusCode == 404) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogBuilder()
                    .printAlertDialog(context, 'Неверный url');
              },
            );
          }
        }
      } else {
        prefs.setString("last_page", "/");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const InternetConnectionError(),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogBuilder().printAlertDialog(context,
              'Обязательные поля "URL" и "Код авторизации" не заполнены');
        },
      );
    }
  }
}
