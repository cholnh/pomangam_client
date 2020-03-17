import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class SignUpAppBar extends AppBar {
  SignUpAppBar(context, {Color backgroundColor = backgroundColor, Color backButtonColor = Colors.black, bool enableBackButton = true}) : super(
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: true,
    leading: enableBackButton
      ? IconButton(
        icon: Icon(CupertinoIcons.back, color: backButtonColor),
        onPressed:() => Navigator.pop(context, false),
      )
      : Container(),
    elevation: 0.0,
  );
}
