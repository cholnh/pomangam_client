import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class SignUpAppBar extends AppBar {
  SignUpAppBar(context, {Color backgroundColor = backgroundColor, Color backButtonColor = Colors.black, bool enableBackButton = true}) : super(
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: true,
    leading: enableBackButton
      ? IconButton(
        icon: Icon(Icons.arrow_back_ios, color: backButtonColor),
        onPressed:() => Navigator.pop(context, false),
      )
      : Container(),
    elevation: 0.0,
  );
}
