import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/sign/user.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:pomangam_client/providers/sign/sign_up_model.dart';
import 'package:pomangam_client/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_app_bar.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_bottom_btn_widget.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_title_widget.dart';
import 'package:provider/provider.dart';

class SignUpPasswordPage extends StatefulWidget {
  @override
  _SignUpPasswordPageState createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {

  SignUpModel _signUpModel;
  SignInModel _signInModel;
  // Color.fromRGBO(0xF4, 0x7E, 60, 1);  -> 연한 주황색
  // Color.fromRGBO(0xE1, 0x5A, 0x2B, 1); -> 포만감 로고색
  // Color.fromRGBO(0xff, 45, 0, 1); -> 오렌지 레드 -> 쨍함
  Color mainColor = primaryColor;
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _signUpModel = Provider.of<SignUpModel>(context, listen: false);
    _signInModel = Provider.of<SignInModel>(context, listen: false);
    _controller = TextEditingController();
    _focusNode = FocusNode();
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    try {
      _controller?.dispose();
      _focusNode?.dispose();
    } catch(err) {
      print('[Debug] _SignUpPasswordPageState.dispose');
    }
    super.dispose();
  }

  Widget _bottomNavigationBar() {
    SignUpModel model = Provider.of<SignUpModel>(context);
    return model.isPasswordFilled
      ? SignUpBottomBtnWidget(
          isActive: !model.signUpPasswordLock,
          backgroundColor: backgroundColor,
          color: mainColor,
          onTap: () {
            if(model.isPasswordFilled) {
              _verify();
            }
          },
      )
      : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => Future.value(false), // 뒤로가기 방지
        child: Scaffold(
          appBar: SignUpAppBar(
              context,
              enableBackButton: false,
              backgroundColor: mainColor
          ),
          bottomNavigationBar: _bottomNavigationBar(),
          backgroundColor: mainColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Column(
              children: <Widget>[
                SignUpTitleWidget(
                  title: '보안코드를 설정합니다.',
                  subTitle: '한 번만 입력하니 정확히 입력해주세요.',
                  color: backgroundColor,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                              width: 250,
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                              child: Consumer<SignUpModel>(
                                builder: (_, model, child) {
                                  return PinCodeTextField(
                                    backgroundColor: mainColor,
                                    length: 4,
                                    controller: _controller,
                                    focusNode: _focusNode,
                                    activeColor: mainColor,
                                    inactiveColor: Colors.deepOrange.shade900,
                                    selectedColor: backgroundColor,
                                    textStyle: TextStyle(color: backgroundColor, locale: Locale('en')),
                                    textInputType: model.isNumberMode
                                      ? TextInputType.number
                                      : TextInputType.text,

                                    obsecureText: true,
                                    animationType: AnimationType.scale,
                                    shape: PinCodeFieldShape.underline,
                                    animationDuration: Duration(milliseconds: 300),
                                    dialogTitle: '포만감',
                                    dialogContent: '코드를 붙여넣기 하시겠습니까?',
                                    fieldHeight: 70,
                                    fieldWidth: 58,
                                    onCompleted: (value) {
                                      model.changePasswordFilled(to: true);
                                    },
                                    onChanged: (value) {
                                      if(value.length < 4) {
                                        model.changePasswordFilled(to: false);
                                      }
                                    },
                                  );
                                },
                              )
                          ),
                          Consumer<SignUpModel>(
                            builder: (_, model, child) {
                              return !model.isPasswordFilled
                                ? GestureDetector(
                                child: Text(
                                    model.isNumberMode
                                      ? '문자로 설정하기'
                                      : '숫자로 설정하기',
                                    style: TextStyle(
                                        color: backgroundColor,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                onTap: () {
                                  model.changeNumberMode(to: !model.isNumberMode);
                                  _focusNode.unfocus();
                                  Future.delayed(Duration(milliseconds: 300), ()
                                    => FocusScope.of(context).requestFocus(_focusNode));
                                },
                              )
                              : Container();
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verify() async {
    try {
      _signUpModel.lockSignUpPassword();  // Lock
      _signUpModel.password = _controller.text;
      User saved = await _signUpModel.postUser();
      if(saved != null) {
        _signUpModel.nickname = saved.nickname;
      } else {
        DialogUtils.dialog(context, '가입이 비정상적으로 처리되었습니다.');
        _routeBack(_signUpModel.returnUrl ?? '/');
        return;
      }
      _signIn(_signUpModel.phoneNumber, _signUpModel.password);
      _routeNext();
    } finally {
      _signUpModel.unLockSignUpPassword();  // Unlock
    }
  }

  void _signIn(String phoneNumber, String password) async {
    await _signInModel.signIn(phoneNumber: phoneNumber, password: password);
  }

  void _routeBack(url) {
    Navigator.popUntil(context, ModalRoute.withName(url));
  }

  void _routeNext() => Navigator.pushNamed(context, '/signup/nickname');
}
