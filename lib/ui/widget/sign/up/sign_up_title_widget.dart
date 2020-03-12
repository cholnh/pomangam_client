import 'package:flutter/material.dart';

class SignUpTitleWidget extends StatelessWidget {

  final String title;
  final String subTitle;
  final Color color;
  final CrossAxisAlignment crossAxisAlignment;

  SignUpTitleWidget({this.title, this.subTitle, this.color = Colors.black, this.crossAxisAlignment = CrossAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Text('$title', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: color)),
        subTitle == null || subTitle.isEmpty
          ? Container()
          : Text('$subTitle', style: TextStyle(color: color))
      ],
    );
  }
}
