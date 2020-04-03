import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class SignInPhoneNumberHelpTextWidget extends StatelessWidget {

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
            height: 1.5
        ),
        children: <TextSpan>[
          TextSpan(text: '포만감은 '),
          TextSpan(text: '휴대폰 번호', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
          TextSpan(text: ' 가입해요.\n'),
          TextSpan(text: '번호는 '),
          TextSpan(text: '안전하게 보관', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' 되며\n'),
          TextSpan(text: '어디에도 공개되지 않아요.\n')
        ],
      ),
    );
  }
}
