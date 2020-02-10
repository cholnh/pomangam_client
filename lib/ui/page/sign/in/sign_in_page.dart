import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed:() => Navigator.pop(context, false),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: Text("sign in"),
      ),
    );
  }
}
