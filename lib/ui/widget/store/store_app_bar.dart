import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class StoreAppBar extends AppBar {
  StoreAppBar(context, {String title}) : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, color: Colors.black),
      onPressed:() => Navigator.pop(context, false),
    ),
    centerTitle: true,
    title: Text(
        '$title',
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.favorite_border, color: primaryColor),
        onPressed: () => print('하튜~'),
      )
    ],
    elevation: 0.0,
  );
}
