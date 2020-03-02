import 'package:flutter/material.dart';

class StoreDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('맥도날드', style: TextStyle(fontWeight: FontWeight.w600)),
          Text('패스트푸드', style: TextStyle(color: Colors.black45)),
        ],
      ),
    );
  }
}
