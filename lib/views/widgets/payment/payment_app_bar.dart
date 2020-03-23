import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentAppBar extends AppBar {
  PaymentAppBar(
    context,
    {
      Icon leadingIcon = const Icon(Icons.close, color: Colors.black),
      String title
    }
  ) : super (
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: leadingIcon,
      onPressed:() => Navigator.pop(context, false),
    ),
    centerTitle: true,
    title: Text('$title', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)),
    elevation: 0.0,
  );
}