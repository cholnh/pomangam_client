import 'package:flutter/material.dart';

class StoreScoreItem extends StatelessWidget {

  final String title;
  final String value;

  StoreScoreItem({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        Text('$title', style: TextStyle(fontSize: 16.0))
      ],
    );
  }
}
