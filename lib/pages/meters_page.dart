import 'dart:convert';

import 'package:diploma/models/meters_info_response.dart';
import 'package:diploma/pages/alert_dialog.dart';
import 'package:diploma/pages/bills_page.dart';
import 'package:diploma/pages/main_page.dart';
import 'package:diploma/pages/settings_page.dart';
import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MetersPage extends StatefulWidget {
  const MetersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MetersPageState();
}

class _MetersPageState extends State<MetersPage> {
  late Future<MetersInfo> metersInfo;

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();

  String _datat1 = "0";
  String _datat2 = "0";
  String _datat3 = "0";

  @override
  void initState() {
    super.initState();
    metersInfo = fetchMetersInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<MetersInfo>(
            future: metersInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    _buildToolbarMeters(context),
                    _buildMainMetersContent(context, snapshot),
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

  Widget _buildToolbarMeters(BuildContext context) {
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
              'Счетчики',
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

  Widget _buildMainMetersContent(
      BuildContext context, AsyncSnapshot<MetersInfo> snapshot) {
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
                'Показания счетчика воды',
                style: CustomTheme.textStyle22_700,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    'Дата последней подачи показаний: ' +
                        snapshot.data!.info.lastbillelwaterdata,
                    style: CustomTheme.textStyle20_400,
                  ),
                ),
              ),
              _printWaterMetersData(snapshot),
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
                'Введите новые показания',
                style: CustomTheme.textStyle22_700,
              ),
              Row(
                children: [
                  _inputWaterDataFields(context, snapshot),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        style: CustomTheme.elevatedButtonStyle,
                        onPressed: () {
                          _submitData("Вода");
                        },
                        child: Text(
                          'Отправить',
                          style: CustomTheme.textStyle20_400,
                        ),
                      ),
                    ),
                  ),
                ],
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
                'Показания счетчика электроэнергии',
                style: CustomTheme.textStyle22_700,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    'Дата последней подачи показаний: ' +
                        snapshot.data!.info.lastbillelectrodata,
                    style: CustomTheme.textStyle20_400,
                  ),
                ),
              ),
              _printElectroMetersData(snapshot),
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
                'Введите новые показания',
                style: CustomTheme.textStyle22_700,
              ),
              Row(
                children: [
                  _inputElectroDataFields(context, snapshot),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        style: CustomTheme.elevatedButtonStyle,
                        onPressed: () {
                          _submitData("Электроэнергия");
                        },
                        child: Text(
                          'Отправить',
                          style: CustomTheme.textStyle20_400,
                        ),
                      ),
                    ),
                  ),
                ],
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
                    onTap: () {},
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

  Widget _printWaterMetersData(AsyncSnapshot<MetersInfo> snapshot) {
    return _printMetersData(snapshot, "Вода");
  }

  Widget _printElectroMetersData(AsyncSnapshot<MetersInfo> snapshot) {
    return _printMetersData(snapshot, "Электроэнергия");
  }

  RenderObjectWidget _printMetersData(
      AsyncSnapshot<MetersInfo> snapshot, String servicebymeter) {
    List meters = snapshot.data!.info.meters;
    bool t1 = false, t2 = false, t3 = false;
    for (var i = 0; i < meters.length; i++) {
      Meter meter = meters[i];
      if (meter.servicebymeter == servicebymeter) {
        if (meter.datat1 != 0.0) {
          t1 = true;
        }
        if (meter.datat2 != 0.0) {
          t2 = true;
        }
        if (meter.datat3 != 0.0) {
          t3 = true;
        }
        if (t1 && t2 && t3) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    'Показания T1: ' + meter.datat1.toString(),
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
                    'Показания T2: ' + meter.datat2.toString(),
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
                    'Показания T3: ' + meter.datat1.toString(),
                    style: CustomTheme.textStyle20_400,
                  ),
                ),
              ),
            ],
          );
        } else if (t1 && t2) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    'Показания T1: ' + meter.datat1.toString(),
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
                    'Показания T2: ' + meter.datat2.toString(),
                    style: CustomTheme.textStyle20_400,
                  ),
                ),
              ),
            ],
          );
        } else if (t1) {
          return Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Text(
                'Показания: ' + meter.datat1.toString(),
                style: CustomTheme.textStyle20_400,
              ),
            ),
          );
        } else {
          continue;
        }
      } else {
        continue;
      }
    }
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Text(
          'Счетчики не обнаружены',
          style: CustomTheme.textStyle20_400,
        ),
      ),
    );
  }

  Widget _inputWaterDataFields(
      BuildContext context, AsyncSnapshot<MetersInfo> snapshot) {
    return _inputDataFields(context, snapshot, "Вода");
  }

  Widget _inputElectroDataFields(
      BuildContext context, AsyncSnapshot<MetersInfo> snapshot) {
    return _inputDataFields(context, snapshot, "Электроэнергия");
  }

  Widget _inputDataFields(BuildContext context,
      AsyncSnapshot<MetersInfo> snapshot, String servicebymeter) {
    List meters = snapshot.data!.info.meters;
    bool t1 = false, t2 = false, t3 = false;
    for (var i = 0; i < meters.length; i++) {
      Meter meter = meters[i];
      if (meter.servicebymeter == servicebymeter) {
        if (meter.datat1 != 0.0) {
          t1 = true;
        }
        if (meter.datat2 != 0.0) {
          t2 = true;
        }
        if (meter.datat3 != 0.0) {
          t3 = true;
        }
        if (t1 && t2 && t3) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: CustomTheme.inputFieldsDecoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.003,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: nodeOne,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CustomTheme.textStyle20_400,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Введите показания T1',
                      hintStyle: CustomTheme.textStyleHint20_400,
                    ),
                    onChanged: (text) {
                      _datat1 = text.trim();
                    },
                    onSubmitted: (text) {
                      FocusScope.of(context).requestFocus(nodeTwo);
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: CustomTheme.inputFieldsDecoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.003,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: nodeTwo,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CustomTheme.textStyle20_400,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Введите показания T2',
                      hintStyle: CustomTheme.textStyleHint20_400,
                    ),
                    onChanged: (text) {
                      _datat2 = text.trim();
                    },
                    onSubmitted: (text) {
                      FocusScope.of(context).requestFocus(nodeThree);
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: CustomTheme.inputFieldsDecoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.003,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: nodeThree,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CustomTheme.textStyle20_400,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Введите показания T3',
                      hintStyle: CustomTheme.textStyleHint20_400,
                    ),
                    onChanged: (text) {
                      _datat3 = text.trim();
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (t1 && t2) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: CustomTheme.inputFieldsDecoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.003,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: nodeOne,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CustomTheme.textStyle20_400,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Введите показания T1',
                      hintStyle: CustomTheme.textStyleHint20_400,
                    ),
                    onChanged: (text) {
                      _datat1 = text.trim();
                    },
                    onSubmitted: (text) {
                      FocusScope.of(context).requestFocus(nodeTwo);
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: CustomTheme.inputFieldsDecoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.003,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: nodeTwo,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CustomTheme.textStyle20_400,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Введите показания T2',
                      hintStyle: CustomTheme.textStyleHint20_400,
                    ),
                    onChanged: (text) {
                      _datat2 = text.trim();
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (t1) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.05,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.width * 0.05,
            ),
            decoration: CustomTheme.inputFieldsDecoration,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01,
                vertical: MediaQuery.of(context).size.height * 0.003,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: CustomTheme.textStyle20_400,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите показания',
                  hintStyle: CustomTheme.textStyleHint20_400,
                ),
                onChanged: (text) {
                  _datat1 = text.trim();
                },
              ),
            ),
          );
        } else {
          continue;
        }
      } else {
        continue;
      }
    }
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: CustomTheme.inputFieldsDecoration,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Text(
          'Счетчики не обнаружены',
          style: CustomTheme.textStyle20_400,
        ),
      ),
    );
  }

  Future<MetersInfo> fetchMetersInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final bio = prefs.getString('bio');
    final authCode = prefs.getString('auth_code');
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    final response = await http.post(
      Uri.parse(url! + "/hs/diploma/get/meters"),
      headers: requestHeaders,
      body: jsonEncode(
        <String, String>{
          'bio': bio!,
        },
      ),
    );

    if (response.statusCode == 200) {
      return MetersInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user info: ${response.statusCode}. ' +
          response.body.toString());
    }
  }

  void _submitData(String servicebymeter) async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url');
    final bio = prefs.getString('bio');
    final authCode = prefs.getString('auth_code');
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ' + authCode!
    };

    String datetime = DateFormat("d.MM.yyy HH:mm:ss").format(DateTime.now());

    if (_datat1 != "0" && _datat2 != "0" && _datat3 != "0" ||
        _datat1 != "0" && _datat2 != "0" ||
        _datat1 != "0") {
      final response = await http.post(
        Uri.parse(url! + "/hs/diploma/put/meters"),
        headers: requestHeaders,
        body: jsonEncode(
          <String, String>{
            'bio': bio!,
            'type': servicebymeter,
            'valuet1': _datat1,
            'valuet2': _datat2,
            'valuet3': _datat3,
            'date': datetime,
          },
        ),
      );
      if (response.statusCode == 200) {
        metersInfo = fetchMetersInfo();
        _datat1 = "0";
        _datat2 = "0";
        _datat3 = "0";
        setState(() {});
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Показания переданы',
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
        if (response.statusCode == 404) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialogBuilder().printAlertDialog(
                  context, 'Пользователь не обнаружен, авторизируйтесь заново');
            },
          );
        } else if (response.statusCode == 403) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialogBuilder().printAlertDialog(context,
                  'Введенные показания меньше сохраненных, проверьте корректность введенных данных');
            },
          );
        } else if (response.statusCode == 402) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialogBuilder().printAlertDialog(context,
                  'Ошибка 402. Обратитесь к администратору для устранения неисправности');
            },
          );
        } else if (response.statusCode == 400) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialogBuilder().printAlertDialog(context,
                  'Неверный тип счетчика. Обратитесь к администратору для устранения неисправности');
            },
          );
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogBuilder()
              .printAlertDialog(context, 'Поля показаний счетчика пустые');
        },
      );
    }
  }
}
