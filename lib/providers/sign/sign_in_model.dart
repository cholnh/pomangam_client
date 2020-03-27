import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/initalizer/initializer.dart';
import 'package:pomangam_client/domains/user/enum/sign_in_state.dart';
import 'package:pomangam_client/domains/user/user.dart';
import 'package:pomangam_client/repositories/sign/sign_repository.dart';

class SignInModel with ChangeNotifier {
  SignRepository _signRepository;

  SignInState signState = SignInState.SIGNED_OUT;
  User userInfo;

  SignInModel() {
    _signRepository = Injector.appInstance.getDependency<SignRepository>();
  }

  Future<User> signIn({
    @required String phoneNumber,
    @required String password
  }) async {
    if(phoneNumber == null || phoneNumber.isEmpty ||
        password == null || password.isEmpty) {
      signState = SignInState.SIGNED_FAIL;
      notifyListeners();
      return null;
    } else {
      signState = SignInState.SIGNING_IN;
      notifyListeners();

      try {
        userInfo = await _signRepository.signIn(
            phoneNumber: phoneNumber,
            password: password);
      } catch(error) {
        signState = SignInState.SIGNED_FAIL;
        notifyListeners();
      }

      signState = SignInState.SIGNED_IN;
      notifyListeners();
      return userInfo;
    }
  }

  void signOut() {
    userInfo = null;
    signState = SignInState.SIGNED_OUT;
    _signRepository.signOut();
    notifyListeners();
  }

  bool isSignIn() {
    return this.signState == SignInState.SIGNED_IN;
  }
}