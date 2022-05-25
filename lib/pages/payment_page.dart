import 'dart:convert';

import 'package:diploma/models/payment_info_response.dart';
import 'package:diploma/pages/main_page.dart';
import 'package:diploma/pages/meters_page.dart';
import 'package:diploma/pages/settings_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'bills_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _inn = "";
  String _number = "";
  String _bik = "";
  String _kpp = "";
  String _recipient = "";
  String _numberLK = "";
  String _purpose = "";
  String _duty = "0";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              _buildToolbarPayment(context),
              _buildMainPaymentContent(context),
              _buildMenu(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarPayment(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: CustomTheme.headerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
            child: IconButton(
              icon: Icon(
                Icons.home,
                size: MediaQuery.of(context).size.width * 0.08,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              'Оплата',
              style: CustomTheme.textStyle22_700,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                size: MediaQuery.of(context).size.width * 0.08,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainPaymentContent(BuildContext mainContext) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(mainContext).size.height * 0.01,
      ),
      child: Column(
        children: [
          GestureDetector(
            child: TextButton(
              onPressed: () {
                _saveRequisites();
                showDialog(
                  context: mainContext,
                  builder: (context) {
                    return AlertDialog(
                      title: _requisitesText(mainContext),
                      actions: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ElevatedButton(
                                style: CustomTheme.elevatedButtonStyle,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Закрыть',
                                  style: CustomTheme.textStyle24_400,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Инструкция для оплаты по реквезитам',
                  style: CustomTheme.textStyle14_400U,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          alignment: Alignment.center,
          decoration: CustomTheme.footerDecoration,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.fromSize(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.009,
                    left: MediaQuery.of(context).size.width * 0.12,
                    bottom: MediaQuery.of(context).size.height * 0.009,
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: CustomTheme.menuButtonDecoration,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BillsPage()),
                        (route) => false,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/images/ruble.svg",
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        const Text("Счета"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox.fromSize(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.009,
                    right: MediaQuery.of(context).size.width * 0.12,
                    bottom: MediaQuery.of(context).size.height * 0.009,
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: CustomTheme.menuButtonDecoration,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MetersPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/images/counter.svg",
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        const Text("Счетчики"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveRequisites() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final authCode = prefs.getString('auth_code');
    final bio = prefs.getString('bio');
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    final response = await http.post(
      Uri.parse(url! + "/hs/diploma/get/payment"),
      headers: requestHeaders,
      body: jsonEncode(
        <String, String>{
          'bio': bio!,
        },
      ),
    );

    if (response.statusCode == 200) {
      Info info = PaymentInfo.fromJson(jsonDecode(response.body)).info;
      _recipient = info.recipient;
      _inn = info.inn;
      _kpp = info.kpp;
      _bik = info.bank.split(" ").first;
      _number = info.bill;
      _numberLK = info.numberLK;
      _purpose = info.purpose;
      _duty = info.duty;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Не удалось загрузить данные. Попробуйте позже',
              style: CustomTheme.textStyle20_400,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      style: CustomTheme.elevatedButtonStyle,
                      onPressed: () {
                        prefs.setBool('auth', false);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const MainPage(),
                          ),
                          (route) => false,
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Выйти',
                        style: CustomTheme.textStyle24_400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    }
  }

  Widget _requisitesText(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Для оплаты по реквезитам необходимо открыть ваше банковское приложение, перейти в оплату по реквезитам и вставить необходимые данные:',
              style: CustomTheme.textStyle20_400,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: TextButton(
                onPressed: () {
                  _saveData(_recipient, context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Получатель',
                    style: CustomTheme.textStyle14_400U,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: TextButton(
                onPressed: () {
                  _saveData(_purpose, context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Назначение платежа',
                    style: CustomTheme.textStyle14_400U,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: TextButton(
                onPressed: () {
                  _saveData(_inn, context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'ИНН получателя',
                    style: CustomTheme.textStyle14_400U,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: TextButton(
                onPressed: () {
                  _saveData(_number, context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Номер счета получателя',
                    style: CustomTheme.textStyle14_400U,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: TextButton(
                onPressed: () {
                  _saveData(_numberLK, context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Номер лицевого счета',
                    style: CustomTheme.textStyle14_400U,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: TextButton(
                onPressed: () {
                  _saveData(_bik, context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'БИК получателя',
                    style: CustomTheme.textStyle14_400U,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: TextButton(
                onPressed: () {
                  _saveData(_kpp, context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'КПП получателя',
                    style: CustomTheme.textStyle14_400U,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: TextButton(
                onPressed: () {
                  _saveData(_duty, context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Сумма к оплате',
                    style: CustomTheme.textStyle14_400U,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveData(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Данные скопированы'),
    ));
  }
}
