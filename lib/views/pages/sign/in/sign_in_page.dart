import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed:() => Navigator.pop(context, false),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Center(
          child: Text("sign in"),
        ),
      ),
    );
  }
}
