import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/router/app_router.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/domains/user/enum/sex.dart';
import 'package:pomangam_client/domains/user/enum/sign_view_state.dart';
import 'package:pomangam_client/providers/sign/sign_up_model.dart';
import 'package:pomangam_client/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_app_bar.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_bottom_btn_widget.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_first_item_widget.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_second_item_widget.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_third_item_widget.dart';
import 'package:pomangam_client/views/widgets/sign/up/sign_up_title_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client/_bases/key/shared_preference_key.dart' as s;

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  SignUpModel _model;
  int _curIdx = 0;
  FocusNode _nameNode, _birthNode, _phoneNode, _sexNode;
  TextEditingController _nameController, _birthController, _sexController, _phoneController;
  ScrollController _scrollController;
  bool _isFirstView = true;

  @override
  void initState() {
    super.initState();
    _model = Provider.of<SignUpModel>(context, listen: false);
    _nameNode = FocusNode();
    _birthNode = FocusNode();
    _phoneNode = FocusNode();
    _sexNode = FocusNode();
    _nameController = TextEditingController();
    _birthController = TextEditingController();
    _sexController = TextEditingController();
    _phoneController = TextEditingController();
    _scrollController = ScrollController();
    _nextToName();
  }


  @override
  void didUpdateWidget(SignUpPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isFirstView = false;
  }

  @override
  void dispose() {
    _nameNode.dispose();
    _birthNode.dispose();
    _phoneNode.dispose();
    _sexNode.dispose();
    _nameController.dispose();
    _birthController.dispose();
    _sexController.dispose();
    _phoneController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _bottomNavigationBar() {
    SignUpModel model = Provider.of<SignUpModel>(context);
    return model.state == SignViewState.finish
      ? SignUpBottomBtnWidget(
        isActive: !model.signUpLock,
        onTap: () => _isAllFilled() ? _verify() : _lastCheck()
      )
      : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignUpAppBar(context),
      bottomNavigationBar: _bottomNavigationBar(),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Consumer<SignUpModel> (
          builder: (_, model, child) {
            return Column(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        SignUpTitleWidget(
                          title: '${model.title}',
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(top: 25.0),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: AnimatedList(
                                      key: _listKey,
                                      controller: _scrollController,
                                      initialItemCount: 0,
                                      reverse: true,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index, animation) {
                                        switch (index) {
                                          case 0:
                                            return SignUpFirstItemWidget(
                                              controller: _nameController,
                                              animation: animation,
                                              focusNode: _nameNode,
                                              model: model,
                                              onChanged: (value) {
                                                if(value.length > 0) {
                                                  _changeSignState(SignViewState.name);
                                                } else {
                                                  _changeSignState(SignViewState.ready);
                                                }
                                              },
                                              onComplete: () {
                                                _isAllFilled()
                                                    ? _lastCheck()
                                                    : _nextToBirth();
                                              },
                                            );
                                          case 1:
                                            return SignUpSecondItemWidget(
                                              animation: animation,
                                              birthController: _birthController,
                                              sexController: _sexController,
                                              birthNode: _birthNode,
                                              sexNode: _sexNode,
                                              onChangedBirth: (value) {
                                                if(value.length >= 6) {
                                                  if(_isAllFilled()) {
                                                    _lastCheck();
                                                  } else {
                                                    _birthNode.unfocus();
                                                    _focus(_sexNode);
                                                    _changeSignState(SignViewState.sex);
                                                  }
                                                } else {
                                                  _changeSignState(SignViewState.birth);
                                                }
                                              },
                                              onChangedSex: (value) {
                                                if(value.length >= 1) {
                                                  _isAllFilled()
                                                      ? _lastCheck()
                                                      : _nextToPhone();
                                                } else {
                                                  _changeSignState(SignViewState.sex);
                                                }
                                              },
                                              onCompleteBirth: () {
                                                _isAllFilled()
                                                    ? _lastCheck()
                                                    : _nextToSex();
                                              },
                                              onCompleteSex: () {
                                                _isAllFilled()
                                                    ? _lastCheck()
                                                    : _nextToPhone();
                                              },
                                            );
                                          case 2:
                                            return SignUpThirdItemWidget(
                                              controller: _phoneController,
                                              animation: animation,
                                              focusNode: _phoneNode,
                                              model: model,
                                              onChanged: (value) {
                                                if(value.length >= 11) {
                                                  if(_isFirstView && _isAllFilled()) {
                                                    _lastCheck();
                                                  } else {
                                                    _changeSignState(SignViewState.finish);
                                                  }
                                                } else {
                                                  _changeSignState(SignViewState.phone);
                                                }
                                              },
                                              onComplete: () {
                                                _lastCheck();
                                              },
                                            );
                                          default:
                                            return Container();
                                        }
                                      }
                                  )
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                model.state == SignViewState.name
                ? SignUpBottomBtnWidget(
                    isActive: !model.signUpLock,
                    onTap: () => _isAllFilled() ? _lastCheck() : _nextToBirth()
                )
                : Container()
              ],
            );
          }
        ),
      ),
    );
  }

  void _nextToName() async {
    await Future.delayed(Duration(milliseconds: 500), () async {
      _setTitle('이름을 입력해주세요.');
      _listKey.currentState.insertItem(_curIdx++);
    });

    Future.delayed(Duration(milliseconds: 300), () {
      _focus(_nameNode);
    });
  }

  void _nextToBirth() {
    _listKey.currentState.insertItem(_curIdx++);
    _setTitle('주민등록번호를 입력해주세요.');
    _changeSignState(SignViewState.birth);
    Future.delayed(Duration(milliseconds: 300), () {
      _nameNode.unfocus();
      _focus(_birthNode);
    });
  }

  void _nextToSex() {
    _changeSignState(SignViewState.sex);
    _birthNode.unfocus();
    _focus(_sexNode);
  }

  void _nextToPhone() {
    _listKey.currentState.insertItem(_curIdx++);
    _setTitle('휴대폰 번호를 입력해주세요.');
    _changeSignState(SignViewState.phone);
    Future.delayed(Duration(milliseconds: 300), () {
      _sexNode.unfocus();
      _focus(_phoneNode);
    });
  }

  void _lastCheck() {
    _setTitle('작성한 정보를 확인해주세요.');
    _unFocusAll();
    _changeSignState(SignViewState.finish);
    Future.delayed(Duration(milliseconds: 150), ()
    => _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 150),
        curve: Curves.linear));
  }

  void _verify() async {
    try {
      _model.lockSignUp(); // Lock

      String phoneNumber = _phoneController.text;
      String name = _nameController.text;
      int year = int.parse(_birthController.text.substring(0, 2));
      int month = int.parse(_birthController.text.substring(2, 4));
      int days = int.parse(_birthController.text.substring(4, 6));
      Sex sex;
      switch (_sexController.text) {
        case '1':
          sex = Sex.MALE;
          year += 1900;
          break;
        case '2':
          sex = Sex.FEMALE;
          year += 1900;
          break;
        case '3':
          sex = Sex.MALE;
          year += 2000;
          break;
        case '4':
          sex = Sex.FEMALE;
          year += 2000;
          break;
        default:
          DialogUtils.dialog(context, '주민번호 뒷자리를 확인해주세요.');
          _focus(_sexNode);
          return;
      }

      if( _validateName(name) &&
          _validateBirth(year, month, days) &&
          await _validatePhoneNumber(phoneNumber)
      ) {
        _setUserInfo(phoneNumber, name, DateTime(year, month, days), sex);
        _routeNext();
      }
    } finally {
      _model.unLockSignUp(); // Unlock
    }
  }

  void _routeNext() => Navigator.pushNamed(context, '/signup/authcode');

  void _setTitle(String to) {
    _model.changeTitle(to: to);
  }

  void _changeSignState(SignViewState to) {
    _model.changeState(to: to);
  }

  void _focus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _setUserInfo(String phoneNumber, String name, DateTime birth, Sex sex) async {
    _model.phoneNumber = phoneNumber;
    _model.name = name;
    _model.birth = birth;
    _model.sex = sex;

    /* Todo 내부 DB로 변경 필요! , 메인화면 진입 전에 idxDeliveryDetailSite 가
        DB 내에 없으면 학교선택하는 페이지로 이동 필수! (로그인, 게스트 둘 다) */
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(s.idxDeliveryDetailSite, 1);

    dynamic idxDeliveryDetailSite = pref.get(s.idxDeliveryDetailSite);
    if(idxDeliveryDetailSite != null && idxDeliveryDetailSite is int) {
      _model.idxDeliveryDetailSite = idxDeliveryDetailSite;
    }
    /* Todo end */
  }

  bool _isAllFilled() {
    String name = _nameController.text;
    String birth = _birthController.text;
    String sex = _sexController.text;
    String phone = _phoneController.text;
    return name.isNotEmpty && birth.isNotEmpty && sex.isNotEmpty && phone.isNotEmpty;
  }

  void _unFocusAll() {
    _nameNode.unfocus();
    _birthNode.unfocus();
    _phoneNode.unfocus();
    _sexNode.unfocus();
  }

  bool _validateName(String name) {
    if(StringUtils.hasEmojiAndSymbol(name)) {
      DialogUtils.dialog(context, '이름을 확인해주세요. $name');
      _focus(_nameNode);
      return false;
    }
    return true;
  }

  bool _validateBirth(int year, int month, int days) {
    if(year > DateTime.now().year ||
        (month < 1 || month > 12) ||
        (days < 1 || days > 31)
    ) {
      DialogUtils.dialog(context, '주민번호 앞자리를 확인해주세요.');
      _focus(_birthNode);
      return false;
    }
    return true;
  }

  Future<bool> _validatePhoneNumber(String phoneNumber) async {
    if (!StringUtils.isValidKoreaPhoneNumber(phoneNumber)) {
      DialogUtils.dialog(context, '휴대폰 번호를 확인해주세요.');
      _focus(_phoneNode);
      return false;
    }
    bool isExist = await _model.verifyExistPhoneNumber(phoneNumber: phoneNumber);
    if(isExist) {
      DialogUtils.dialog(context, '이미 가입된 번호입니다.');
      _focus(_phoneNode);
      return false;
    }
    return true;
  }
}