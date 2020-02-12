import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/initalizer/initializer.dart';
import 'package:pomangam_client/common/network/api/network_service.dart';
import 'package:pomangam_client/common/network/domain/server_health.dart';
import 'package:pomangam_client/common/network/domain/token.dart';
import 'package:pomangam_client/common/network/repository/authorization_repository.dart';
import 'package:pomangam_client/common/network/repository/resource_repository.dart';
import 'package:pomangam_client/domain/sign/user.dart';

class Api implements NetworkService {

  final OauthTokenRepository oauthTokenRepository;
  final ResourceRepository resourceRepository;

  Api({this.oauthTokenRepository, this.resourceRepository});


  /// ## initialize - deprecated
  ///
  /// [locale] 변경할 locale
  /// Oauth2.0 토큰 초기화, resource header 의 locale 변경.
  /// SharedPreference 에 저장되어 있는 token 을 우선적으로 load 함.
  /// load 된 token 은 서버에 보내져 유효한 token 인지 아닌지 검사를 진행.
  /// SharedPreference 에 토큰이 저장되어 있지 않다면 guest token 발급하여 load.
  /// 발급 된 토큰은 네트워크 헤더와 SharedPreference 내부에 저장됨.
  /// Dio Network Exception 발생 시 외부로 Exception 전달(내부 try-catch 설정 안 함)
  /// 외부 Repository 구현 시, try-catch 구현 or 외부로 전파 필요.
  ///
  @deprecated
  @override
  Future initialize({Locale locale}) async {
    Token token = await oauthTokenRepository.loadToken(); // 외부 error 발생 가능
    if(token != null) {
      token
        ..saveToDioHeader() // 네트워크 헤더에 저장 : Authorization Bearer {access_token}
        ..saveToDisk();     // SharedPreference 내부에 저장
    }
    if(locale != null) {
      setResourceLocale(locale: locale);
    }
  }


  /// ## signIn - deprecated (Initializer.initializeToken 사용)
  ///
  /// [phoneNumber] ID 에 해당하는 핸드폰번호 입력
  /// [password] 비밀번호
  /// 유저 계정 서버로 전달 -> 유효성 체크 -> login token 발급 -> return 유저 정보
  ///
  @deprecated
  Future<User> signIn({
    @required String phoneNumber,
    @required String password
  }) async {
    User user;
    Token token = await oauthTokenRepository.issueLoginToken(
        phoneNumber: phoneNumber,
        password: password);

    if(token != null) {
      token
        ..saveToDisk()        // SharedPreference 내부에 저장
        ..saveToDioHeader();  // 네트워크 헤더에 저장 : Authorization Bearer {access_token}
      user = User.fromJson((await resourceRepository.get(url: '/users/$phoneNumber')).data);
    }
    return user;
  }


  /// ## healthCheck
  ///
  /// 서버 health 상태 반환
  ///
  Future<ServerHealth> healthCheck() => oauthTokenRepository.serverHealthCheck();


  /// ## signOut - deprecated
  ///
  /// 로그아웃
  /// SharedPreference 내부 token 값 삭제, Dio Header 내부 token 값 삭제.
  /// 로그아웃 후 View 단에서 초기화 후, 홈('/') 으로 이동 필요.
  ///
  @deprecated
  void signOut() {
    Token.clearFromDisk();
    Token.clearFromDioHeader();
  }


  /// ## setResourceLocale - deprecated
  ///
  /// [locale] 변경할 locale
  /// resource header 의 locale 변경.
  ///
  @deprecated
  Api setResourceLocale({Locale locale = const Locale('ko')}) {
    resourceRepository.setResourceLocale(locale); // resource locale 변경
    return this;
  }


  /// ## get
  ///
  /// [url] http 요청 url
  /// Http **GET** method call
  /// Dio Network Exception 발생 시 외부로 Exception 전달(내부 try-catch 설정 안 함)
  /// 외부 Repository 구현 시, try-catch 구현 or 외부로 전파 필요.
  ///
  @override
  Future<Response> get({
    @required String url
  }) {
    Function logic = () => resourceRepository.get(url: url);
    return logic().catchError((error) => _errorHandler(error, logic));
  }


  /// ## post
  ///
  /// [url] http 요청 url
  /// [jsonData] http body data(raw JSON[application/json])
  /// Http **POST** method call (데이터 입력)
  /// Dio Network Exception 발생 시 외부로 Exception 전달(내부 try-catch 설정 안 함)
  /// 외부 Repository 구현 시, try-catch 구현 or 외부로 전파 필요.
  ///
  @override
  Future<Response> post({
    @required String url,
    Map jsonData
  }) {
    Function logic = () => resourceRepository.post(url: url, jsonData: jsonData);
    return logic().catchError((error) => _errorHandler(error, logic));
  }


  /// ## patch
  ///
  /// [url] http 요청 url
  /// [jsonData] http body data(raw JSON[application/json])
  /// Http **PATCH** method call (데이터 수정)
  /// Dio Network Exception 발생 시 외부로 Exception 전달(내부 try-catch 설정 안 함)
  /// 외부 Repository 구현 시, try-catch 구현 or 외부로 전파 필요.
  ///
  @override
  Future<Response> patch({
    @required String url,
    Map jsonData
  }) {
    Function logic = () => resourceRepository.patch(url: url, jsonData: jsonData);
    return logic().catchError((error) => _errorHandler(error, logic));
  }


  /// ## put **deprecated** patch 사용 권장
  ///
  /// [url] http 요청 url
  /// [jsonData] http body data(raw JSON[application/json])
  /// Http **PUT** method call
  /// Dio Network Exception 발생 시 외부로 Exception 전달(내부 try-catch 설정 안 함)
  /// 외부 Repository 구현 시, try-catch 구현 or 외부로 전파 필요.
  ///
  @deprecated
  @override
  Future<Response> put({
    @required String url,
    Map jsonData
  }) {
    Function logic = () => resourceRepository.put(url: url, jsonData: jsonData);
    return logic().catchError((error) => _errorHandler(error, logic));
  }


  /// ## delete
  ///
  /// [url] http 요청 url
  /// Http **DELETE** method call (데이터 삭제)
  /// Dio Network Exception 발생 시 외부로 Exception 전달(내부 try-catch 설정 안 함)
  /// 외부 Repository 구현 시, try-catch 구현 or 외부로 전파 필요.
  ///
  @override
  Future<Response> delete({
    @required String url
  }) {
    Function logic = () => resourceRepository.delete(url: url);
    return logic().catchError((error) => _errorHandler(error, logic));
  }

  _errorHandler(error, logic) async {
    // 토큰 재 요청
    if(error is DioError) {
      switch(error.response.statusCode) {
        case HttpStatus.unauthorized: // 401
          await Injector.appInstance.getDependency<Initializer>()
            .initialize(
              onDone: logic,
              onServerDown: () => print('[Debug] DioCore.interceptor!!server down..'),
            );
          break;
        default:
          break;
      }
    }
  }
}