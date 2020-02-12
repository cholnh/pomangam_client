import 'package:flutter/foundation.dart';
import 'package:pomangam_client/common/key/shared_preference_key.dart' as s;
import 'package:pomangam_client/common/network/dio/dio_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TokenMode { GUEST, LOGIN }

class Token {

  String accessToken;
  String tokenType;
  int expiresIn;
  String scope;
  String refreshToken;
  TokenMode tokenMode;

  Token({
    @required this.accessToken,
    @required this.tokenType,
    @required this.expiresIn,
    @required this.scope,
    @required this.refreshToken,
    @required this.tokenMode});

  Token.fromJson(Map<String, dynamic> json) :
    tokenMode = TokenMode.GUEST,
    accessToken = json['access_token'],
    tokenType = json['token_type'],
    expiresIn = json['expires_in'],
    scope = json['scope'],
    refreshToken = json['refresh_token'];

  static Future<Token> loadFromDisk() async {
    try {
      String accessToken, tokenType, scope, refreshToken;
      int expiresIn;
      TokenMode tokenMode;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String strTokenMode = prefs.get(s.tokenMode);
      assert(strTokenMode != null);

      if(strTokenMode == 'guest') {
        tokenMode = TokenMode.GUEST;
      } else if(strTokenMode == 'login') {
        tokenMode = TokenMode.LOGIN;
        refreshToken = prefs.get(s.refreshToken);
        assert(refreshToken != null);
      } else {
        assert(false);
      }

      accessToken = prefs.get(s.accessToken);
      assert(accessToken != null);

      tokenType = prefs.get(s.tokenType);
      assert(tokenType != null);

      expiresIn = prefs.get(s.expiresIn);
      assert(expiresIn != null);

      scope = prefs.get(s.scope);
      assert(scope != null);

      return Token(
          accessToken: accessToken,
          tokenType: tokenType,
          expiresIn: expiresIn,
          scope: scope,
          refreshToken: refreshToken,
          tokenMode: tokenMode);
    } catch (e) {}
    return null;
  }

  saveToDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(tokenMode == TokenMode.GUEST) {
      prefs.setString(s.tokenMode, 'guest');
    } else if(tokenMode == TokenMode.LOGIN) {
      prefs.setString(s.tokenMode, 'login');
      prefs.setString(s.refreshToken, refreshToken);
    }

    prefs.setString(s.accessToken, accessToken);
    prefs.setString(s.tokenType, tokenType);
    prefs.setInt(s.expiresIn, expiresIn);
    prefs.setString(s.scope, scope);
    return this;
  }

  static clearFromDisk() async {
    await SharedPreferences.getInstance()
      ..remove(s.tokenMode)
      ..remove(s.refreshToken)
      ..remove(s.accessToken)
      ..remove(s.tokenType)
      ..remove(s.expiresIn)
      ..remove(s.scope);
  }

  saveToDioHeader() {
    DioCore().addResourceHeader({
      'Authorization':'Bearer ' + accessToken
    }); // interceptor header 추가
    return this;
  }

  static clearFromDioHeader() {
    DioCore().resource.interceptors.clear();
  }

  @override
  String toString() {
    return 'Token{accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, scope: $scope, refreshToken: $refreshToken, tokenMode: $tokenMode}';
  }
}