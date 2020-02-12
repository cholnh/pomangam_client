import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/common/network/domain/server_health.dart';
import 'package:pomangam_client/common/network/domain/token.dart';
import 'package:pomangam_client/domain/sign/user.dart';

class Initializer {

  Api api;

  Initializer({this.api});

  Future initialize({
    Locale locale = const Locale('ko'),
    Function onDone,
    Function onServerError,
  }) async {
    api.resourceRepository.setResourceLocale(locale); // server 통신 header 에 locale 추가

    if( await _isServerDown(onServerError: onServerError) ) return;
    if( !await _hasFcmToken() ) await _fcmTokenNotIssuedHandler();

    User user = await initializeToken();
    if(user != null) {
      _saveDB(user);
    }

    if(onDone != null) onDone();
  }

  Future<User> initializeToken() async {
    Token token;
    User user;

    token = await api.oauthTokenRepository.loadToken();

    if(token != null) {
      token
        ..saveToDisk()        // SharedPreference 내부에 저장
        ..saveToDioHeader();  // 네트워크 헤더에 저장 : Authorization Bearer {access_token}

      String phoneNumber = _loadDBString('phoneNumber');
      if(token.tokenMode == TokenMode.LOGIN && phoneNumber.isNotEmpty) {
        user = User.fromJson((await api.get(url: '/users/$phoneNumber')).data);
      }
    }
    return user;
  }

  /// ## _isServerDown
  ///
  /// 서버 health indicator 가 반환하는 server health status 검사
  ///
  Future<bool> _isServerDown({Function onServerError}) async {
    ServerHealth health = await api.healthCheck();
    switch(health) {
      case ServerHealth.UP:
        return false;
      case ServerHealth.DOWN:
      case ServerHealth.MAINTENANCE:
      case ServerHealth.UNKNOWN:
      onServerError();
    }
    return true;
  }

  /// ## _hasFcmToken
  ///
  /// 내부 db 에 fcm token, fidx(서버에 등록된 fcm index) 있는지 검사
  ///
  Future<bool> _hasFcmToken() async {
    try {
      int fidx = _loadDBInt('__fidx__');
      String fcmToken =  _loadDBString('__fcmToken__');

      return fidx > 0 && fcmToken.isNotEmpty;
    } catch(error) {
      return false;
    }
  }

  /// ## _fcmTokenNotIssuedHandler
  ///
  /// fcm token 요청 후 내부 db 에 저장, 서버 db 에 저장 -> 서버에서 발급한 fidx 내부 db 에 저장.
  ///
  Future _fcmTokenNotIssuedHandler() async {
    String fcmToken;
    try{
      _saveDB(await _requestFcmToken());  // fcm token 저장
      _saveDB(await _postFcmToken(fcmToken: fcmToken)); // 서버전송 후 fidx 저장
    } catch(error) {
      return;
    }
  }


  /// ## _issueLoginToken
  ///
  Future<Token> _issueLoginToken({String phoneNumber, String password}) async {
    try {
      return await api.oauthTokenRepository
          .issueLoginToken(phoneNumber: phoneNumber, password: password);
    } catch(error) {
      return await _issueGuestToken();
    }
  }

  /// ## _issueGuestToken
  ///
  Future<Token> _issueGuestToken() async {
    return await api.oauthTokenRepository
        .issueGuestToken();
  }

  Future<bool> _isLoginUser() async {
    // Todo: 내부 db 에 User Info 저장되어 있는지 검사
    return false;
  }

  int _loadDBInt(dynamic what) {
    // Todo: 내부 db 값 불러오기 구현
    print('$what loaded !');
    return 1212;
  }

  String _loadDBString(dynamic what) {
    // Todo: 내부 db 값 불러오기 구현
    print('$what loaded !');
    return 'fcm token zz';
  }

  void _saveDB(dynamic item) {
    // Todo: 내부 db 값 저장 구현
    print('$item saved !');
  }

  Future<String> _requestFcmToken() {
    // Todo: fcm token 발급 요청 구현.
    return Future.delayed(Duration(seconds: 1), () => 'fcm token dummy');
  }

  Future<int> _postFcmToken({String fcmToken}) {
    // Todo: fcmToken -> 서버 전송 -> fidx 반환
    int fidx = 123;
    return Future.delayed(Duration(seconds: 1), () => fidx);
  }
}