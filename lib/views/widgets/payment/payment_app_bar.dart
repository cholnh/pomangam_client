import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentAppBar extends AppBar {
  PaymentAppBar(context) : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(Icons.close, color: Colors.black),
      onPressed:() => Navigator.pop(context, false),
    ),
    centerTitle: true,
    title:  Text('결제', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)),
    elevation: 0.0,
  );
}