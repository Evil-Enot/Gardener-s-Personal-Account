import 'package:diploma/pages/bills_page.dart';
import 'package:diploma/pages/main_page.dart';
import 'package:diploma/pages/meters_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              _buildToolbarSettings(context),
              _buildSettingsContent(context),
              _buildMenu(context),
            ],
          ),
        ),
      ),
    );
  }

  //FIX
  //TODO()
  Widget _buildToolbarSettings(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF9C0),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
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
            child: const Text(
              'Настройки',
              style: TextStyle(
                color: Color(0xFF373737),
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
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

  Widget _buildSettingsContent(BuildContext context) {
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
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Включить уведомления',
                        style: TextStyle(
                          color: Color(0xFF373737),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Switch(
                        value: value,
                        onChanged: (bool value) {
                          setState(() => this.value = value);
                        },
                        activeTrackColor: Color(0xFFFFF9C0),
                        activeColor: Color(0xFFFFED4D),
                      ),
                    ],
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
          decoration: const BoxDecoration(
            color: Color(0xFFFFF9C0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
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
                  decoration: BoxDecoration(
                    color: Color(0xFFFFED4D),
                    border:
                        Border.all(width: 2, color: const Color(0xFF000000)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  child: InkWell(
                    splashColor: Color(0xFFFFED4D), // splash color
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
                        Text("Счета"), // text
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
                  decoration: BoxDecoration(
                    color: Color(0xFFFFED4D),
                    border:
                        Border.all(width: 2, color: const Color(0xFF000000)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  child: InkWell(
                    splashColor: Color(0xFFFFED4D),
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
                        Text("Счетчики"), // text
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
