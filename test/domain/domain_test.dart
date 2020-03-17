import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:pomangam_client/domains/sign/user.dart';

import '../testable.dart';

class DomainTest implements Testable {

  Api _api;

  @override
  setUp() {
    Injector injector = Injector.appInstance;
    _api = injector.getDependency<Api>();
  }

  @override
  run() {
    test('domain api test', () async {
      // Given
      User user = User(
          phoneNumber: '01055555552',
          name: '테스터5',
          deliveryDetailSite: DeliveryDetailSite(idx: 1),
          password: '1234'
      );
      print('${user.toJson()}');


      // When
      await _api
          .initialize(locale: Locale('ko'))
          .catchError((err) => print('server is closed - $err'));

      try {
        Response response = await _api.post(url: '/users', data: user.toJson());

        print('response : $response');  // 리스폰스 (데이터로 사용하면 안됨)
        print('statusCode : ${response.statusCode}'); // 상태코드
        print('statusMessage : ${response.statusMessage}'); // ??
        print('data : ${response.data}'); // json 형태로 반환

      } catch(err) {
        _errorHandler(err);
      }

      // Then
      expect(1+1, 2);
    });
  }

  _errorHandler(DioError err) {
    print('err : $err');
    if(err is DioError) {
      // network error
      switch(err.response.statusCode) {
        case HttpStatus.badRequest: // 400
          print('400 error - ${err.response.data}');
          break;
        case HttpStatus.unauthorized: // 401
          print('401 error - ${err.response.data}');
          break;
        case HttpStatus.internalServerError:  // 500
          print('500 error - ${err.response.data}');
          break;
        default: // maybe serviceUnavailable 503
          print('${err.response.statusCode} error - ${err.response.data}');
          break;
      }
    } else {
      // common error
      print('errorHandler - $err');
    }
  }

  @override
  tearDown() {
  }

}