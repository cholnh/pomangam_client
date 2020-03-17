import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:pomangam_client/domains/sign/auth_code_result.dart';
import 'package:pomangam_client/domains/sign/enum/auth_code_state.dart';
import 'package:pomangam_client/domains/sign/enum/sex.dart';
import 'package:pomangam_client/domains/sign/enum/sign_view_state.dart';
import 'package:pomangam_client/domains/sign/user.dart';
import 'package:pomangam_client/repositories/sign/sign_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client/_bases/key/shared_preference_key.dart' as s;

class SignUpModel with ChangeNotifier {
  SignRepository _signRepository;

  SignViewState state = SignViewState.ready;
  String title = '';
  String returnUrl;

  // sign up page
  bool signUpLock = false;

  // authCode page
  bool isAuthCodeFilled = false;
  AuthCodeState authCodeState = AuthCodeState.ready;
  final int maxAuthCodeSendCount = 5;
  int authCodeSendCount = 0;
  bool signUpAuthCodeLock = false;

  // password page
  bool isPasswordFilled = false;
  bool isNumberMode = true;
  bool signUpPasswordLock = false;

  // nickname page
  bool isValidNicknameFilled = true;
  bool signUpNicknameLock = false;

  // user info input
  int idxDeliveryDetailSite;
  String phoneNumber, name, password, nickname;
  DateTime birth;
  Sex sex;

  SignUpModel() {
    _signRepository = Injector.appInstance.getDependency<SignRepository>();
  }

  void changeState({
    @required SignViewState to
  }) {
    state = to;
    notifyListeners();
  }

  void changeTitle({
    @required String to
  }) {
    title = to;
    notifyListeners();
  }

  void changeAuthCodeFilled({
    @required bool to
  }) {
    isAuthCodeFilled = to;
    notifyListeners();
  }

  void changePasswordFilled({
    @required bool to
  }) {
    isPasswordFilled = to;
    notifyListeners();
  }

  void changeNumberMode({
    @required bool to
  }) {
    isNumberMode = to;
    notifyListeners();
  }

  void changeValidNicknameFilled({
    @required bool to
  }) {
    isValidNicknameFilled = to;
    notifyListeners();
  }

  void lockSignUp() {
    signUpLock = true;
    notifyListeners();
  }

  void unLockSignUp() {
    signUpLock = false;
    notifyListeners();
  }

  void lockSignUpAuthCode() {
    signUpAuthCodeLock = true;
    notifyListeners();
  }

  void unLockSignUpAuthCode() {
    signUpAuthCodeLock = false;
    notifyListeners();
  }

  void lockSignUpPassword() {
    signUpPasswordLock = true;
    notifyListeners();
  }

  void unLockSignUpPassword() {
    signUpPasswordLock = false;
    notifyListeners();
  }

  void lockSignUpNickname() {
    signUpNicknameLock = true;
    notifyListeners();
  }

  void unLockSignUpNickname() {
    signUpNicknameLock = false;
    notifyListeners();
  }


  Future<bool> verifyExistPhoneNumber({
    @required String phoneNumber
  }) async {
    try {
      return await _signRepository.verifyPhoneNumber(
          phoneNumber: phoneNumber);
    } catch(error) {
      return true;
    }
  }

  Future<bool> requestAuthCodeForJoin() async {
    if(phoneNumber != null &&
        phoneNumber.isNotEmpty) {

      AuthCodeResult result;

      try {
        authCodeSendCount++;
        result = await _signRepository.requestAuthCodeForJoin(
            phoneNumber: phoneNumber);
      } catch(error) {
        authCodeState = AuthCodeState.fail;
        notifyListeners();
        return false;
      }

      if(result.code == 'success') {
        authCodeState = AuthCodeState.success;

        notifyListeners();
        return true;
      }
    }
    authCodeState = AuthCodeState.fail;
    notifyListeners();
    return false;
  }

  Future<bool> verifyAuthCodeForJoin({
    @required String code
  }) async {
    try {
      return await _signRepository.verifyAuthCodeForJoin(
          phoneNumber: phoneNumber,
          code: code);
    } catch(error) {
      return false;
    }
  }

  Future<User> postUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int fIdx = prefs.getInt(s.idxFcmToken);
      return await _signRepository.postUser(
        user: User(
          idxFcmToken: fIdx,
          phoneNumber: phoneNumber,
          name: name,
          birth: birth,
          sex: sex,
          deliveryDetailSite: DeliveryDetailSite(idx: idxDeliveryDetailSite),
          password: password
      ));
    } catch(error) {
      return null;
    }
  }

  Future<bool> isExistNickname({
    @required String nickname
  }) async {
    try {
      return await _signRepository.isExistByNickname(
          nickname: nickname);
    } catch(error) {
      return false;
    }
  }

  Future<bool> patchNickname({
    @required String nickname
  }) async {
    try {
      await _signRepository.patchUser(
        user: User(
          phoneNumber: phoneNumber,
          nickname: nickname
      ));
      return true;
    } catch(error) {
      return false;
    }
  }
}