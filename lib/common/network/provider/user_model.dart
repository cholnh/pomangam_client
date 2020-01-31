import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/common/network/domain/sign_state.dart';
import 'package:pomangam_client/common/network/domain/user_dto.dart';
import 'package:pomangam_client/common/network/service/network_service.dart';
import 'package:injector/injector.dart';

class UserModel with ChangeNotifier {

  NetworkService _networkService;
  SignState signState;
  UserDto userInfo;

  UserModel() {
    _networkService = Injector.appInstance.getDependency<NetworkService>();
    signState = SignState.signedOut;
  }

  Future<UserDto> signIn({
    String username, String password
  }) async {
    if(username == null || username.isEmpty ||
        password == null || password.isEmpty) {
      signState = SignState.signedFail;
      notifyListeners();
      return null;
    } else {
      signState = SignState.signingIn;
      notifyListeners();

      try {
        userInfo = await _networkService
            .signIn(username: username, password: password);
      } catch(e) {
        signState = SignState.signedFail;
        notifyListeners();
        throw e;
      }

      signState = SignState.signedIn;
      notifyListeners();
      return userInfo;
    }
  }

  signOut() {
    userInfo = null;
    signState = SignState.signedOut;
    _networkService.signOut();
    notifyListeners();
  }

}