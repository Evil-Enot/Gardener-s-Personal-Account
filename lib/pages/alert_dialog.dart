import 'package:diploma/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class AlertDialogBuilder {
  AlertDialogBuilder();

  AlertDialog printAlertDialog(BuildContext context, String text) {
    return AlertDialog(
      title: Text(
        text,
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
  }
}
