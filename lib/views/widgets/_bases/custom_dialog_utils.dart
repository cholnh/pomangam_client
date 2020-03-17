import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              child: Text('확인'),
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
