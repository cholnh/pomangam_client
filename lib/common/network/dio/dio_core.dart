import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';

class DioCore {

  Dio oauth;
  Dio resource;

  static final DioCore _singleton = DioCore._internal();

  factory DioCore() {
    return _singleton;
  }

  DioCore._internal() {
    initialize();
  }

  void initialize() {
    final BaseOptions options = BaseOptions(
      baseUrl: Endpoint.serverDomain,
      connectTimeout: Endpoint.connectTimeout,
      receiveTimeout: Endpoint.receiveTimeout,
    );

    oauth = Dio(options);
    resource = Dio(options);

    InterceptorsWrapper interceptorsWrapper = InterceptorsWrapper(
      onError: (DioError dioError) async {
        // 토큰 재 요청
        switch(dioError.response.statusCode) {
          case HttpStatus.unauthorized: // 401
            await Injector.appInstance.getDependency<Api>()
              .initialize()
              .catchError((err) => print('[Debug] DioCore.interceptor!!server down..'));
            break;
          default:
            break;
        }
        throw dioError;
      }
    );

    resource.interceptors.add(interceptorsWrapper);
  }

  void setResourceLocale(Locale locale) {
    addResourceHeader({
      'Accept-Language': locale
    });
  }

  void addResourceHeader(Map<String, dynamic> header) {
    resource.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        options.headers.addAll(header);
        return options;
      }
    ));
  }
}