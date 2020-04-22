
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pomangam_client/_bases//network/constant/endpoint.dart';
import 'package:pomangam_client/_bases/network/dio/dio_core.dart';
import 'package:pomangam_client/_bases/network/domain/server_health.dart';
import 'package:pomangam_client/_bases/network/domain/token.dart';

class OauthTokenRepository {

  /// ## loadToken
  ///
  /// SharedPreference 에 저장되어 있는 token 을 우선적으로 load 함(loadFromDisk).
  /// load 된 token 은 서버에 보내져 유효한 token 인지 아닌지 검사를 진행(_isValid).
  /// SharedPreference 에 토큰이 저장되어 있지 않다면 guest token 발급하여 load.
  /// login token 만료 시, 재발급(refreshLoginToken).
  /// Dio Network Exception 발생 시 외부로 Exception 전달(내부 try-catch 설정 안 함).
  /// 외부 Repository 구현 시, try-catch 구현 or 외부로 전파 필요.
  ///
  Future<Token> loadToken() async {
    Token token;
    try {
      token = await Token.loadFromDisk() // Load SharedPreference
            ?? await issueGuestToken(); // SharedPreference 에 token 이 없는 경우

      token = await isValid(accessToken: token.accessToken)
        ? token
        : token.tokenMode == TokenMode.GUEST
          ? await issueGuestToken()
          : await refreshLoginToken(refreshToken: token.refreshToken);
    } catch(e) {
      token = await issueGuestToken(); // guest token 발급, 외부 error 발생 가능
    }
    return token;
  }

  /// ## isValid
  ///
  /// [accessToken] 유효성 검사를 진행할 token
  /// 서버 Oauth Check Token Controller 에서 유효성 검사 진행 후 결과 반환
  ///
  /// ### [POST /oauth/check_token]
  /// HTTP STATUS CODE
  /// [200] 정상 발급 -> true
  /// [400] invalid token -> catch error -> false
  /// [500] 서버 내부 Exception, accessToken 이 body 내에 없을 경우 -> catch error -> false
  ///
  @visibleForTesting
  Future<bool> isValid({String accessToken}) async {
    try {
      var res = await DioCore().oauth.post('/oauth/check_token',
          data: FormData.fromMap({
            'token': accessToken
          })
      );
      if(res != null && res.statusCode == 200) {
        return true;
      }
    } catch(e) {}
    return false;
  }

  /// ## issueGuestToken
  ///
  /// guest token 발급 (client_credentials)
  /// 내부 Endpoint 에 저장되어 있는 guestOauthTokenHeader 를 헤더에 추가.
  /// guestOauthTokenHeader 값이 변경되지 않는 한, guest token 정상 발급 가능.
  ///
  /// ### [POST /oauth/token]
  /// HTTP STATUS CODE
  /// * [200] 정상 발급 -> return Token
  /// * [401] guestOauthTokenHeader 가 invalid 한 경우 -> 외부 error 전파
  /// * [500] 서버 내부 Exception -> 외부 error 전파
  ///
  Future<Token> issueGuestToken() async {
    Token token;
    var res = await DioCore().oauth.post('/oauth/token',
        options: Options(headers: {
          'Authorization': 'Basic ' + Endpoint.guestOauthTokenHeader
        }),
        data: FormData.fromMap({
          'grant_type': 'client_credentials'
        })
    );
    if(res != null && res.statusCode == 200) {
      token = Token.fromJson(res.data);
    }
    return token;
  }

  /// ## issueLoginToken
  ///
  /// login token 발급 (password)
  /// 내부 Endpoint 에 저장되어 있는 loginOauthTokenHeader 를 헤더에 추가.
  /// body 에 form-data 형식으로 username, password 를 저장하여 POST 로 전송.
  ///
  /// ### [POST /oauth/token]
  /// HTTP STATUS CODE
  /// [200] 정상 발급 -> return Token
  /// [400] username, password 가 invalid 한 경우 -> 외부 error 전파
  /// [401] loginOauthTokenHeader 가 invalid 한 경우 -> 외부 error 전파
  /// [500] 서버 내부 Exception -> 외부 error 전파
  ///
  Future<Token> issueLoginToken({String phoneNumber, String password}) async {
    Token token;
    var res = await DioCore().oauth.post('/oauth/token',
        options: Options(headers: {
          'Authorization': 'Basic ' + Endpoint.loginOauthTokenHeader
        }),
        data: FormData.fromMap({
          'grant_type': 'password',
          'username': phoneNumber,
          'password': password
        })
    );
    if(res != null && res.statusCode == 200) {
      token = Token.fromJson(res.data)
        ..tokenMode = TokenMode.LOGIN;
    }
    return token;
  }

  /// ## refreshLoginToken
  ///
  /// login token 재 발급 (refresh_token)
  /// 내부 Endpoint 에 저장되어 있는 loginOauthTokenHeader 를 헤더에 추가.
  /// body 에 form-data 형식으로 refresh_token 를 저장하여 POST 로 전송.
  ///
  /// ### [POST /oauth/token]
  /// HTTP STATUS CODE
  /// [200] 정상 발급 -> return Token
  /// [400] refresh_token 가 invalid 한 경우 -> 외부 error 전파
  /// [401] loginOauthTokenHeader 가 invalid 한 경우 -> 외부 error 전파
  /// [500] 서버 내부 Exception -> 외부 error 전파
  ///
  Future<Token> refreshLoginToken({String refreshToken}) async {
    Token token;
    var res = await DioCore().oauth.post('/oauth/token',
        options: Options(headers: {
          'Authorization': 'Basic ' + Endpoint.loginOauthTokenHeader
        }),
        data: FormData.fromMap({
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken
        })
    );
    if(res != null && res.statusCode == 200) {
      token = Token.fromJson(res.data)
        ..tokenMode = TokenMode.LOGIN;
    }
    return token;
  }

  /// ## serverHealthCheck
  ///
  /// login token 재 발급 (refresh_token)
  /// 내부 Endpoint 에 저장되어 있는 loginOauthTokenHeader 를 헤더에 추가.
  /// body 에 form-data 형식으로 refresh_token 를 저장하여 POST 로 전송.
  ///
  /// ### [GET /application/healthCheck]
  /// HTTP STATUS CODE
  /// [200] OK -> 서버상태 정상 -> ServerHealth.OK
  /// [200] DOWN -> 서버 다운 -> ServerHealth.DOWN
  /// [200] MAINTENANCE -> 서버 유지보수중 -> ServerHealth.MAINTENANCE
  /// [200] UNKNOWN -> 서버상태 알수없음 -> ServerHealth.UNKNOWN
  /// [응답없음] catch error -> 서버 강제종료 예상 -> ServerHealth.UNKNOWN
  ///
  Future<ServerHealth> serverHealthCheck() async {
    try {
      var res = await DioCore().oauth.get('/health');
      if(res != null && res.statusCode == 200) {
        String status = res.data['status'];
        switch(status) {
          case 'UP': return ServerHealth.UP;
          case 'DOWN': return ServerHealth.DOWN;
          case 'MAINTENANCE': return ServerHealth.MAINTENANCE;
          default: return ServerHealth.UNKNOWN;
        }
      }
    } catch(e) {
      print(e);
      return ServerHealth.UNKNOWN;
    }
    return ServerHealth.UNKNOWN;
  }
}