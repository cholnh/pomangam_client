import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back, color: Colors.black),
            onPressed:() => Navigator.pop(context, false),
          ),
          elevation: 0.0,
        ),
        body: Center(
          child: Text("sign in"),
        ),
      ),
    );
  }
}
