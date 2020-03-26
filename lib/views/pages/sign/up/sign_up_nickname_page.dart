import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/sign/sign_up_model.dart';
import 'package:pomangam_client/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_app_bar.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_bottom_btn_widget.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_title_widget.dart';
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

  Widget _bottomNavigationBar() {
    SignUpModel model = Provider.of<SignUpModel>(context);
    return SignUpBottomBtnWidget(
      isActive: !model.signUpNicknameLock,
      title: '완료',
      onTap: () {
        _verify();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => Future.value(false), // 뒤로가기 방지
        child: Scaffold(
          appBar: SignUpAppBar(context, enableBackButton: false),
          bottomNavigationBar: _bottomNavigationBar(),
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: SignUpTitleWidget(
                    title: '포만이가 되신것을 환영합니다.',
                    subTitle: '아래 닉네임으로 활동하시게 됩니다.',
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
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
              ],
            ),
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
        _routeNext(_model.returnUrl, arguments: _model.arguments);
        return;
      }
      if(StringUtils.isValidNickname(nickname)) {
        bool isExisted = await _model.isExistNickname(nickname: nickname);
        bool isPatched = await _model.patchNickname(nickname: nickname);
        if(!isExisted && isPatched) {
          _routeNext(_model.returnUrl, arguments: _model.arguments);
          return;
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

  void _routeNext(url, {Object arguments}) {
    //Navigator.popUntil(context, ModalRoute.withName(url ?? '/'));
    Navigator.pushReplacementNamed(context, url, arguments: arguments);
  }

  void _verifyError(String cause) {
    DialogUtils.dialog(context, '$cause');
    _focus(_focusNode);
    _model.changeValidNicknameFilled(to: false);
  }
}
