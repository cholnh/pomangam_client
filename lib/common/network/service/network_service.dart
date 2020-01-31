import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/network/domain/user_dto.dart';

abstract class NetworkService {
  initialize({
    Function networkErrorHandler
  });
  Future<UserDto> signIn({String username, String password});
  signOut();
  signUp();
  get({
    @required String url,
    Locale locale
  });
  post({
    @required String url,
    Locale locale,
    Map jsonData
  });
  patch({
    @required String url,
    Locale locale,
    Map jsonData
  });
  put({
    @required String url,
    Locale locale,
    Map jsonData
  });
  delete({
    @required String url,
    Locale locale
  });
}