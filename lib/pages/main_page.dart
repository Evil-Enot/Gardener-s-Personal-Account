// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;

import 'package:diploma/pages/bills_page.dart';
import 'package:diploma/pages/info_page.dart';
import 'package:diploma/pages/meters_page.dart';
import 'package:diploma/pages/settings_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              _buildToolbar(context),
              _buildMainContent(context),
              _buildMenu(context),
            ],
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

  Widget _buildMainContent(BuildContext context) {
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
                    'Валеев Артур Рудольфович',
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
                    'Тел: 8(223) 456-96-14',
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
                    'E-mail: ravine_deep@smail.ru',
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
                    'Адрес: Лесная, 11',
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
                    'Площадь участка: 400,00 м. кв.',
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
                    'Кадастровый номер: \nинформация отсутствует',
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
                    text: TextSpan(
                      text: 'Текущий долг: ',
                      style: CustomTheme.textStyle20_400,
                      children: const [
                        TextSpan(
                          text: '11.87',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                          ),
                        )
                      ],
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
                    'Дата последней подачи показаний: 30.02.2021 ',
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
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/images/ruble.svg",
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        const Text("Счета"), // text
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
                        const Text("Счетчики"), // text
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
}
