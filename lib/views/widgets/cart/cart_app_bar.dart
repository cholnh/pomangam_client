import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartAppBar extends AppBar {
  CartAppBar(context) : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, color: Colors.black),
      onPressed:() => Navigator.pop(context, false),
    ),
    centerTitle: true,
    title:  Text('장바구니', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)),
    elevation: 0.0,
  );
}