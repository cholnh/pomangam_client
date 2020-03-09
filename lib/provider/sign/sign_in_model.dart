import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/initalizer/initializer.dart';
import 'package:pomangam_client/domain/sign/enum/sign_in_state.dart';
import 'package:pomangam_client/domain/sign/user.dart';
import 'package:pomangam_client/repository/sign/sign_repository.dart';

class SignInModel with ChangeNotifier {
  SignRepository _signRepository;

  SignInState signState = SignInState.signedOut;
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
      signState = SignInState.signedFail;
      notifyListeners();
      return null;
    } else {
      signState = SignInState.signingIn;
      notifyListeners();

      try {
        userInfo = await _signRepository.signIn(
            phoneNumber: phoneNumber,
            password: password);
      } catch(error) {
        signState = SignInState.signedFail;
        notifyListeners();
      }

      signState = SignInState.signedIn;
      notifyListeners();
      return userInfo;
    }
  }

  void signOut() {
    userInfo = null;
    signState = SignInState.signedOut;
    _signRepository.signOut();
    notifyListeners();
  }

  Future<bool> isSignIn() async {
    return Initializer.isSignIn();
  }
}