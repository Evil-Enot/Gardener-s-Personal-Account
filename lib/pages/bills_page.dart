import 'dart:convert';

import 'package:diploma/models/bills_info_response.dart';
import 'package:diploma/pages/alert_dialog.dart';
import 'package:diploma/pages/main_page.dart';
import 'package:diploma/pages/meters_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  late Future<BillsInfo> billsInfo;

  @override
  void initState() {
    super.initState();
    billsInfo = _fetchBillsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<BillsInfo>(
            future: billsInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    _buildToolbarBills(context),
                    _buildMainBillsContent(context, snapshot),
                    _buildMenu(context),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  //FIX
  //TODO()
  Widget _buildToolbarBills(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: CustomTheme.headerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: SvgPicture.asset("assets/images/home.svg"),
            color: Colors.black,
            iconSize: MediaQuery.of(context).size.width * 0.05,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            },
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.2,
              right: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Text(
              'Счета',
              style: CustomTheme.textStyle22_700,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.access_time_filled_outlined),
            color: Color(0xFFFFF9C0), //Fix!!!
            iconSize: MediaQuery.of(context).size.width * 0.05,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMainBillsContent(
      BuildContext context, AsyncSnapshot<BillsInfo> snapshot) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: RichText(
                    text: snapshot.data!.info.billduty > 0
                        ? TextSpan(
                            text: 'Текущий долг: ',
                            style: CustomTheme.textStyle20_400,
                            children: [
                              TextSpan(
                                text: snapshot.data!.info.billduty.toString(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Montserrat',
                                ),
                              )
                            ],
                          )
                        : snapshot.data!.info.billoverpayment > 0
                            ? TextSpan(
                                text: 'Текущая переплата: ',
                                style: CustomTheme.textStyle20_400,
                                children: [
                                  TextSpan(
                                    text: snapshot.data!.info.billoverpayment
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              )
                            : const TextSpan(
                                text:
                                    'Ошибка на сервере, обраитесь к администратору',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: snapshot.data!.info.lastbillelwater.isNotEmpty
                      ? Text(
                          'Дата последней подачи показаний по водоснабжению: ' +
                              snapshot.data!.info.lastbillelwater,
                          style: CustomTheme.textStyle20_400,
                        )
                      : Text(
                          'Счетчики по водоснабжению не обнаружены',
                          style: CustomTheme.textStyle20_400,
                        ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    'Дата последней подачи показаний по электричеству: ' +
                        snapshot.data!.info.lastbillelectro,
                    style: CustomTheme.textStyle20_400,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
                indent: MediaQuery.of(context).size.width * 0.05,
                endIndent: MediaQuery.of(context).size.width * 0.05,
                color: Colors.black,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      style: CustomTheme.elevatedButtonStyle,
                      onPressed: () {
                        _getReceipt(context);
                      },
                      child: Text(
                        'Получить квитанцию',
                        style: CustomTheme.textStyle24_400,
                      ),
                    ),
                  ),
                ),
              ),
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
                      onPressed: () {},
                      child: Text(
                        'Оплатить',
                        style: CustomTheme.textStyle24_400,
                      ),
                    ),
                  ),
                ),
              )
            ],
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
                    onTap: () {},
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

  Future<BillsInfo> _fetchBillsInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final bio = prefs.getString('bio');
    final authCode = prefs.getString('auth_code');

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    final response = await http.post(
      Uri.parse(url! + "/hs/diploma/get/bills"),
      headers: requestHeaders,
      body: jsonEncode(
        <String, String>{
          'bio': bio!,
        },
      ),
    );

    if (response.statusCode == 200) {
      return BillsInfo.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}. ' +
          response.body.toString());
      throw Exception('Failed to load user info');
    }
  }

  void _getReceipt(context) async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final bio = prefs.getString('bio');
    final authCode = prefs.getString('auth_code');

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    final response = await http.post(
      Uri.parse(url! + "/hs/diploma/get/receipt"),
      headers: requestHeaders,
      body: jsonEncode(
        <String, String>{
          'bio': bio!,
        },
      ),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Квитанция сформирована и отправлена на почту',
              style: CustomTheme.textStyle20_400,
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogBuilder().printAlertDialog(context,
              'Не удалось сформировать квитанцию. Обратитесь к администратору');
        },
      );
    }
  }
}
