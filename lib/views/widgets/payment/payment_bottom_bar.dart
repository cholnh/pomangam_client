import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class PaymentBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => _onSelected(context),
        child: SizedBox(
          height: 50.0,
          child: Container(
            color: primaryColor,
            child: Center(
              child: Text('적용하기', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 17.0)),
            ),
          ),
        ),
      ),
    );
  }

  void _onSelected(BuildContext context) {
    Navigator.pop(context, false);

    // toast 메시지
    Fluttertoast.showToast(
        msg: "적용완료",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: titleFontSize
    );
  }
}
