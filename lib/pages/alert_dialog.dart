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
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFFED4D),
              shape: const StadiumBorder(),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.08,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Закрыть",
              textAlign: TextAlign.center,
              style: CustomTheme.textStyle20_400,
            ),
          ),
        )
      ],
    );
  }
}
