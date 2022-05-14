import 'dart:convert';

import 'package:diploma/pages/auth_page.dart';
import 'package:diploma/pages/bills_page.dart';
import 'package:diploma/pages/info_page.dart';
import 'package:diploma/pages/meters_page.dart';
import 'package:diploma/pages/settings_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_info_response.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<UserInfo> userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = _fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: FutureBuilder<UserInfo>(
            future: userInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    _buildToolbar(context),
                    _buildMainContent(context, snapshot),
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

  Widget _buildToolbar(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: CustomTheme.headerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: SvgPicture.asset("assets/images/info.svg"),
            color: Colors.black,
            iconSize: MediaQuery.of(context).size.width * 0.05,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const InfoPage()));
            },
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.2,
              right: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Text(
              'Профиль',
              style: CustomTheme.textStyle22_700,
            ),
          ),
          IconButton(
            icon: SvgPicture.asset("assets/images/settings.svg"),
            color: Colors.black,
            iconSize: MediaQuery.of(context).size.width * 0.05,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(
      BuildContext context, AsyncSnapshot<UserInfo> snapshot) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Владелец',
                style: CustomTheme.textStyle22_700,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    snapshot.data!.info.name,
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
            ],
          ),
          Column(
            children: [
              Text(
                'Контакты',
                style: CustomTheme.textStyle22_700,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    'Тел: ' + snapshot.data!.info.number,
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
                    'E-mail: ' + snapshot.data!.info.email,
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
            ],
          ),
          Column(
            children: [
              Text(
                'Недвижимость',
                style: CustomTheme.textStyle22_700,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    snapshot.data!.info.address,
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
                    'Площадь участка: ' +
                        snapshot.data!.info.area.toString() +
                        ' м. кв.',
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
                    snapshot.data!.info.cadastral.isEmpty
                        ? 'Кадастровый номер: \nинформация отсутствует'
                        : 'Кадастровый номер: \n' +
                            snapshot.data!.info.cadastral,
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
            ],
          ),
          Column(
            children: [
              Text(
                'Счета',
                style: CustomTheme.textStyle22_700,
              ),
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
                  child: Text(
                    'Дата последней подачи показаний по водоснабжению: ' +
                        snapshot.data!.info.lastbillelwater,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BillsPage(),
                        ),
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

  Future<UserInfo> _fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final bio = prefs.getString('bio');
    final authCode = prefs.getString('auth_code');

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    final response = await http.post(
      Uri.parse(url! + "/hs/diploma/get/profile"),
      headers: requestHeaders,
      body: jsonEncode(
        <String, String>{
          'bio': bio!,
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserInfo.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Пользователь с таким ФИО не обнаружен. Перезайдите в приложение',
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
                            builder: (BuildContext context) => const AuthPage(),
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
    throw Exception('Failed to load user info');
  }
}
