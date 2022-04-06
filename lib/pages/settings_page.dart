import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

  Widget _buildToolbarSettings(BuildContext context) {
    return Text('data');
  }

  Widget _buildSettingsContent(BuildContext context) {
    return Text('data');
  }

  Widget _buildMenu(BuildContext context) {
    return Text('data');
  }
}