import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart' as theme;

class SignUpBottomBtn extends StatelessWidget {

  final bool isActive;
  final Function onTap;
  final Color backgroundColor;
  final Color color;
  final String title;

  SignUpBottomBtn({this.isActive = true, this.onTap, this.backgroundColor = theme.primaryColor, this.color = theme.backgroundColor, this.title = '확인'});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
          child: GestureDetector(
            child: Container(
              color: backgroundColor,
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: Center(
                child: isActive
                  ? Text('$title', style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 17.0))
                  : CircularProgressIndicator(
                      backgroundColor: color,
                      strokeWidth: 2.0,
                  ),
              ),
            ),
            onTap: isActive
                ? onTap
                : (){},
          ),
        ),
    );
  }
}
