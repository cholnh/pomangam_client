import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart' as theme;

class SignUpBottomBtnWidget extends StatelessWidget {

  final bool isActive;
  final Function onTap;
  final Color backgroundColor;
  final Color color;
  final String title;

  SignUpBottomBtnWidget({this.isActive = true, this.onTap, this.backgroundColor = theme.primaryColor, this.color = theme.backgroundColor, this.title = '확인'});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          child: SizedBox(
            height: 65.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: backgroundColor,
                child: Center(
                  child: isActive
                    ? Text('$title', style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 17.0))
                    : CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
          onTap: isActive
              ? onTap
              : (){},
        ),
      );
  }
}
