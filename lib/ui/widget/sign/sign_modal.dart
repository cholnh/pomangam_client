import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class SignModal extends StatelessWidget {
  final Function onSignIn;
  final Function onSignUp;

  SignModal({this.onSignIn, this.onSignUp});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 30.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 40.0),
                    child: Align(
                      child: Text('로그인이 필요합니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 300.0,
                      height: 48.0,
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(color: primaryColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: Text('간편가입', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold)),
                    ),
                    onTap: onSignUp,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Divider(color: Colors.black26),
                  ),
                  GestureDetector(
                    child: Align(
                      child: Text('기존 계정으로 로그인', style: TextStyle(color: Colors.grey)),
                    ),
                    onTap: onSignIn,
                  )
                ],
              ),
            )
          ]
      )
    );
  }
}
