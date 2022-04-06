import 'package:flutter/material.dart';

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
    return Text(("data"));
  }

  Widget _buildMainContent(BuildContext context) {
    return Text(("data"));
  }

  Widget _buildMenu(BuildContext context) {
    return Text(("data"));
  }
}
