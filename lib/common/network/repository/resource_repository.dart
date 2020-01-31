import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:pomangam_client/common/network/dio/dio_core.dart';
import 'package:pomangam_client/common/network/exception/oauth_exception.dart';
import 'package:pomangam_client/common/network/repository/authorization_repository.dart';

class ResourceRepository {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  final OauthTokenRepository oauthTokenRepository;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ResourceRepository({this.oauthTokenRepository});
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  get({
    @required String url,
    Locale locale,
  }) async {
    return await _httpAction((url, options, formData) async
    => await DioCore().resource.get(url, options: options),
        url, locale, null);
  }

  post({
    @required String url,
    Locale locale,
    Map jsonData
  }) async {

    return await _httpAction((url, options, formData) async
    => await DioCore().resource.post(url, options: options, data: formData),
        url, locale, jsonData);
  }

  patch({
    @required String url,
    Locale locale,
    Map jsonData
  }) async {
    return await _httpAction((url, options, formData) async
    => await DioCore().resource.patch(url, options: options, data: formData),
        url, locale, jsonData);
  }

  put({
    @required String url,
    Locale locale,
    Map jsonData
  }) async {

    return await _httpAction((url, options, formData) async
    => await DioCore().resource.put(url, options: options, data: formData),
        url, locale, jsonData);
  }

  delete({
    @required String url,
    Locale locale
  }) async {

    await _httpAction((url, options) async
      => await DioCore().resource.delete(url, options: options),
      url, locale, null);
  }

  _httpAction(Function innerFunc, String url, Locale locale, Map jsonData) async {
    Options options = Options(headers: {
      'Accept-Language': locale == null ? 'ko' : locale.languageCode,
    });

    var res = await innerFunc(url, options, jsonData)
        .catchError((err) async {
      await resourceErrorHandler(err);
      return await innerFunc(url, options, jsonData);
    });

    if(res != null && res.statusCode == 200) {
      return res.data;
    }
    return null;
  }

  resourceErrorHandler(err) async {
    if(err is DioError) {
      switch(err.response.statusCode) {
        case HttpStatus.unauthorized:
          await oauthTokenRepository.loadToken()
            ..saveToDioHeader()
            ..saveToDisk();
          break;
      }
    } else {
      throw OauthNetworkException(OauthExceptionType.serverClosed);
    }
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}