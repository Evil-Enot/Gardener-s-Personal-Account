import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              _buildToolbarInfo(context),
              _buildInfoContent(context),
              _buildMenu(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarInfo(BuildContext context) {
    return Text('data');
  }

  Widget _buildInfoContent(BuildContext context) {
    return Text('data');
  }

  Widget _buildMenu(BuildContext context) {
    return Text('data');
  }
}
