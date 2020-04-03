import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:provider/provider.dart';

class SignInAuthCodeHelpTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.left,
      softWrap: true,
      text: TextSpan(
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black.withOpacity(0.8),
          ),
          children: <TextSpan>[
            TextSpan(text: '인증번호', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
            TextSpan(text: '를 입력해주세요.'),
          ],
      )
    );
  }
}
