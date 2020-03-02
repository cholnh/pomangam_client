import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/util/string_utils.dart';
import 'package:pomangam_client/provider/sign/sign_up_model.dart';
import 'package:pomangam_client/ui/widget/common/custom_dialog_utils.dart';
import 'package:pomangam_client/ui/widget/sign/up/sign_up_app_bar.dart';
import 'package:pomangam_client/ui/widget/sign/up/sign_up_bottom_btn.dart';
import 'package:pomangam_client/ui/widget/sign/up/sign_up_title.dart';
import 'package:provider/provider.dart';

class SignUpNicknamePage extends StatefulWidget {
  @override
  _SignUpNicknamePageState createState() => _SignUpNicknamePageState();
}

class _SignUpNicknamePageState extends State<SignUpNicknamePage> {

  SignUpModel _model;
  TextEditingController _controller;
  FocusNode _focusNode;
  String savedNickname;

  @override
  void initState() {
    super.initState();
    _model = Provider.of<SignUpModel>(context, listen: false);
    savedNickname = _model.nickname;
    _controller = TextEditingController()
      ..text = savedNickname;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false), // 뒤로가기 방지
      child: Scaffold(
        appBar: SignUpAppBar(context, enableBackButton: false),
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: SignUpTitle(
                  title: '포만이가 되신것을 환영합니다.',
                  subTitle: '아래 닉네임으로 활동하시게 됩니다.',
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 180.0,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: TextFormField(
                          controller: _controller,
                          focusNode: _focusNode,
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontWeight: FontWeight.bold, locale: Locale('ko')),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            labelText: '닉네임',
                            alignLabelWithHint: true,
                            suffixText: '님'
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: IconButton(
                          icon: Icon(Icons.loop),
                        ),
                      ),
                      Consumer<SignUpModel>(
                        builder: (_, model, child) {
                          return model.isValidNicknameFilled
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  '10자 이내의 한글, 알파벳, 숫자만 가능합니다.',
                                  style: TextStyle(color: primaryColor),
                                  textAlign: TextAlign.start,
                                )
                              );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Consumer<SignUpModel>(
                builder: (_, model, child) {
                  return  SignUpBottomBtn(
                    isActive: !model.signUpNicknameLock,
                    title: '완료',
                    onTap: () {
                      _verify();
                    },
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verify() async {
    try {
      _model.lockSignUpNickname();  // Lock
      String nickname = _controller.text;
      if(nickname == savedNickname) {
        return;
      }
      if(StringUtils.isValidNickname(nickname)) {
        if( !await _model.isExistNickname(nickname: nickname) &&
            await _model.patchNickname(nickname: nickname)
        ) {
          _routeNext(_model.returnUrl);
        } else {
          _verifyError('이미 등록된 닉네임입니다.');
        }
      } else {
        _verifyError('닉네임을 다시 입력해주세요.');
      }
    } finally {
      _model.unLockSignUpNickname();  // Unlock
    }
  }

  void _focus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _routeNext(url) {
    Navigator.popUntil(context, ModalRoute.withName(url ?? '/'));
  }

  void _verifyError(String cause) {
    DialogUtils.dialog(context, '$cause');
    _focus(_focusNode);
    _model.changeValidNicknameFilled(to: false);
  }
}
