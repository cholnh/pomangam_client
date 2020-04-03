import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:pomangam_client/providers/sign/sign_up_model.dart';
import 'package:provider/provider.dart';

void showSignModal({BuildContext context, String returnUrl = '/', Object arguments}) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      context: context,
      builder: (context) {
        return SignModal(
          onSignIn: () {
            Provider.of<SignInModel>(context, listen: false)
            ..returnUrl = returnUrl
            ..arguments = arguments;
            Navigator.pushNamed(context, '/signin');
          },
          onSignUp: () {
            Provider.of<SignUpModel>(context, listen: false)
            ..returnUrl = returnUrl
            ..arguments = arguments;
            Navigator.pushNamed(context, '/signup');
          }
        );
      }
  );
}

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
              padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 40.0),
                    child: Align(
                      child: Text('로그인이 필요합니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
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
                      child: Text('간편가입', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: titleFontSize)),
                    ),
                    onTap: onSignUp,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                    child: Divider(color: Colors.black26),
                  ),
                  GestureDetector(
                    child: Material(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text('기존 계정으로 로그인', style: TextStyle(color: Colors.grey, fontSize: titleFontSize))),
                      ),
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
