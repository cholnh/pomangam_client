import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/network/domain/token.dart';
import 'package:pomangam_client/common/network/domain/user.dart';
import 'package:pomangam_client/common/network/domain/user_dto.dart';
import 'package:pomangam_client/common/network/exception/oauth_exception.dart';
import 'package:pomangam_client/common/network/repository/authorization_repository.dart';
import 'package:pomangam_client/common/network/repository/resource_repository.dart';
import 'package:pomangam_client/common/network/service/network_service.dart';

class NetworkServiceImpl implements NetworkService {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  final OauthTokenRepository oauthTokenRepository;
  final ResourceRepository resourceRepository;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  NetworkServiceImpl({this.oauthTokenRepository, this.resourceRepository});
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  @override
  initialize({Function networkErrorHandler}) async {
    Token _token = await oauthTokenRepository
      .loadToken()
      .catchError((err) {
        if(err.error is SocketException) {
          networkErrorHandler();
        }
    });

    if(_token != null) {
      _token
        ..saveToDioHeader()
        ..saveToDisk();
    } else {
      throw OauthNetworkException(OauthExceptionType.networkError);
    }
  }

  @override
  Future<UserDto> signIn({
    @required String username,
    @required String password
  }) async {
    Token _token = await oauthTokenRepository
      .issueLoginToken(username: username, password: password)
      .catchError((err) {});

    if(_token != null) {
      _token
        ..saveToDisk()
        ..saveToDioHeader();
      return UserDto.fromEntity(User.fromJson(await resourceRepository.get(url: '/user/myInfo')));
    } else {
      throw OauthNetworkException(OauthExceptionType.badCredentials);
    }
  }

  @override
  signOut() {
    Token.clearFromDisk();
    Token.clearFromDioHeader();
  }

  @override
  signUp() {

  }

  @override
  get({
    @required String url,
    Locale locale
  }) => resourceRepository.get(url: url, locale: locale);


  @override
  post({
    @required String url,
    Locale locale,
    Map jsonData
  }) => resourceRepository.post(url: url, locale: locale, jsonData: jsonData);

  @override
  patch({
    @required String url,
    Locale locale,
    Map jsonData
  }) => resourceRepository.patch(url: url, locale: locale, jsonData: jsonData);

  @override
  put({
    @required String url,
    Locale locale,
    Map jsonData
  }) => resourceRepository.put(url: url, locale: locale, jsonData: jsonData);

  @override
  delete({
    @required String url,
    Locale locale
  }) => resourceRepository.delete(url: url, locale: locale);
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}