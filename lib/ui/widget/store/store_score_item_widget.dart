import 'package:flutter/material.dart';

class StoreScoreItemWidget extends StatelessWidget {

  final String title;
  final String value;

  StoreScoreItemWidget({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
        Text('$title', style: TextStyle(fontSize: 13.0))
      ],
    );
  }
}
