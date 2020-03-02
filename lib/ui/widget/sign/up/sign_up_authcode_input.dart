import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

@deprecated
class SignUpAuthCodeInput extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode focusNode;
  final String placeholder;
  final Function onTap;
  final Function(String) onChanged;

  SignUpAuthCodeInput({this.controller, this.focusNode, this.placeholder,
      this.onTap, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: EdgeInsets.all(3.0),
      child: CupertinoTextField(
        controller : controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        showCursor: false,
        textAlign: TextAlign.center,
        focusNode: focusNode,
        placeholder: '$placeholder',
        decoration: BoxDecoration(
          border: focusNode.hasFocus
            ? Border.all(
              width: 1.5,
              color: primaryColor,
            )
            : Border.all(
              width: 1.0,
            )
        ),
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}
