import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/common/key/shared_preference_key.dart' as s;
import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/common/network/domain/server_health.dart';
import 'package:pomangam_client/common/network/domain/token.dart';
import 'package:pomangam_client/domain/sign/user.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Initializer {

  Api api;
  bool isServerDown = false;

  Initializer({this.api});

  Future initialize({
    BuildContext context,
    Function onDone,
    Function onServerError,
    Function deliverySiteNotIssuedHandler,
  }) async {
    try {
      log('start initialize', name: 'Initializer.initialize', time: DateTime.now());

      await initializeNetwork(onServerError: onServerError);
      await initializeLocale(locale: context != null ? Localizations.localeOf(context) : Locale('ko'));
      await _initializeNotification();
      await _initializeToken();
      await _initializeModelData(context: context, deliverySiteNotIssuedHandler: deliverySiteNotIssuedHandler);
      if(onDone != null) onDone();

      log('success', name: 'Initializer.initialize', time: DateTime.now());
    } catch(error) {
      log('fail', name: 'Initializer.initialize', time: DateTime.now(), error: error);
    }
  }

  Future<void> initializeLocale({Locale locale}) async {
    try {
      log('start initializeLocale', name: 'Initializer.initializeLocale', time: DateTime.now());
      api.setResourceLocale(locale: locale); // server 통신 header 에 locale 추가
      log('success', name: 'Initializer.initializeLocale', time: DateTime.now());
    } catch(error) {
      log('fail', name: 'Initializer.initializeLocale', time: DateTime.now(), error: error);
    }
  }

  Future<bool> initializeNetwork({Function onServerError}) async {
    try {
      log('start initializeNetwork', name: 'Initializer.initializeNetwork', time: DateTime.now());
      isServerDown = await _isServerDown(onServerError: onServerError);
      log('success', name: 'Initializer.initializeNetwork', time: DateTime.now());
      return isServerDown;
    } catch(error) {
      log('fail', name: 'Initializer.initializeNetwork', time: DateTime.now(), error: error);
      return false;
    }
  }

  Future<void> initializeNotification({Function onServerError}) async {
    isServerDown = await initializeNetwork(onServerError: onServerError);
    return _initializeNotification();
  }
  Future<void> _initializeNotification() async {
    try {
      log('start initializeNotification', name: 'Initializer.initializeNotification', time: DateTime.now());
      if(isServerDown) return;
      if( !await _hasFcmToken() ) await _fcmTokenNotIssuedHandler();
      log('success', name: 'Initializer.initializeNotification', time: DateTime.now());
    } catch(error) {
      log('fail', name: 'Initializer.initializeNotification', time: DateTime.now(), error: error);
    }
  }

  Future<void> initializeToken({Function onServerError}) async {
    isServerDown = await initializeNetwork(onServerError: onServerError);
    _initializeToken();
  }
  Future<void> _initializeToken() async {
    try {
      log('start initializeToken', name: 'Initializer.initializeToken', time: DateTime.now());
      if(isServerDown) return;

      Token token = await api.oauthTokenRepository.loadToken();
      if(token != null) {
        token
          ..saveToDisk()        // SharedPreference 내부에 저장
          ..saveToDioHeader();  // 네트워크 헤더에 저장 : Authorization Bearer {access_token}

        String phoneNumber = await _loadInPrefs(s.userPhoneNumber);
        if(token.tokenMode == TokenMode.LOGIN && phoneNumber.isNotEmpty) {
          User.fromJson((await api.get(url: '/users/$phoneNumber')).data)
            ..saveToDisk();
        }
      }
      log('success', name: 'Initializer.initializeToken', time: DateTime.now());
    } catch(error) {
      log('fail', name: 'Initializer.initializeToken', time: DateTime.now(), error: error);
    }
  }

  /// ## signIn
  ///
  /// [phoneNumber] ID 에 해당하는 핸드폰번호 입력
  /// [password] 비밀번호
  /// 유저 계정 서버로 전달 -> 유효성 체크 -> login token 발급 -> return 유저 정보
  ///
  Future<User> signIn({
    @required String phoneNumber,
    @required String password
  }) async {
    User user;
    Token token = await api.oauthTokenRepository.issueLoginToken(
        phoneNumber: phoneNumber,
        password: password);

    if(token != null) {
      token
        ..saveToDisk()        // SharedPreference 내부에 저장
        ..saveToDioHeader();  // 네트워크 헤더에 저장 : Authorization Bearer {access_token}

      (await SharedPreferences.getInstance()).setString(s.userPhoneNumber, phoneNumber);
      user = User.fromJson((await api.get(url: '/users/$phoneNumber')).data)
        ..saveToDisk();
    }
    return user;
  }

  Future<void> initializeModelData({BuildContext context, Function onServerError, Function deliverySiteNotIssuedHandler}) async {
    isServerDown = await initializeNetwork(onServerError: onServerError);
    _initializeModelData(context: context, deliverySiteNotIssuedHandler: deliverySiteNotIssuedHandler);
  }
  Future<void> _initializeModelData({BuildContext context, Function deliverySiteNotIssuedHandler}) async {
    try {
      log('start initializeData', name: 'Initializer.initializeData', time: DateTime.now());
      if(isServerDown || context == null) return;

      SharedPreferences pref = await SharedPreferences.getInstance();
      int ddIdx = pref.getInt(s.idxDeliveryDetailSite) ?? 1;
      int dIdx = pref.getInt(s.idxDeliverySite) ?? 1;

      if(dIdx == null || ddIdx == null) {
        deliverySiteNotIssuedHandler();
      } else {
        // 배달지 설정
        await Provider.of<DeliverySiteModel>(context, listen: false)
          .changeUserDeliverySite(dIdx: dIdx);

        // 배달지 상세주소 설정
        await Provider.of<DeliveryDetailSiteModel>(context, listen: false)
          .changeUserDeliveryDetailSite(dIdx: dIdx, ddIdx: ddIdx);

        // 배달가능시간 설정
        await Provider.of<OrderTimeModel>(context, listen: false)
          .fetch(forceUpdate: true, dIdx: dIdx);
      }
      log('success', name: 'Initializer.initializeData', time: DateTime.now());
    } catch(error) {
      log('fail', name: 'Initializer.initializeData', time: DateTime.now(), error: error);
    }
  }


  /// ## signOut
  ///
  /// 로그아웃
  /// SharedPreference 내부 token 값 삭제, Dio Header 내부 token 값 삭제.
  /// 로그아웃 후 View 단에서 초기화 후, 홈('/') 으로 이동 필요.
  ///
  void signOut() {
    Token.clearFromDisk();
    Token.clearFromDioHeader();
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
      return await _loadInPrefs(s.idxFcmToken) > 0
          && (await _loadInPrefs(s.fcmToken)).isNotEmpty;
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
      _saveInPrefs(s.fcmToken, await _requestFcmToken());  // fcm token 저장
      _saveInPrefs(s.idxFcmToken, await _postFcmToken(fcmToken: fcmToken)); // 서버전송 후 fidx 저장
    } catch(error) {
      return;
    }
  }

  Future<dynamic> _loadInPrefs(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<bool> _saveInPrefs(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(value is int) {
      return prefs.setInt(key, value);
    } else if(value is double) {
      return prefs.setDouble(key, value);
    } else if(value is String) {
      return prefs.setString(key, value);
    } else if(value is bool) {
      return prefs.setBool(key, value);
    } else if(value is List<String>) {
      return prefs.setStringList(key, value);
    }
    return false;
  }

  Future<String> _requestFcmToken() {
    // Todo: fcm token 발급 요청 구현.
    return Future.delayed(Duration(microseconds: 100), () => 'fcm token dummy');
  }

  Future<int> _postFcmToken({String fcmToken}) {
    // Todo: fcmToken -> 서버 전송 -> fidx 반환
    int fidx = 123;
    return Future.delayed(Duration(microseconds: 100), () => fidx);
  }
}