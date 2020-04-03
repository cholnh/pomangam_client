import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class DialogUtils {
  static void dialog(BuildContext context, String contents, {Function(BuildContext) onPressed}) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(''),
          content: Text('$contents'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인', style: TextStyle(color: primaryColor)),
              onPressed: onPressed != null
                  ? () => onPressed(dialogContext)
                  : () => Navigator.of(dialogContext).pop()
            ),
          ],
        );
      },
    );
  }
}
