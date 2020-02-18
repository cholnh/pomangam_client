import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/network/dio/dio_core.dart';
import 'package:pomangam_client/common/network/repository/authorization_repository.dart';

class ResourceRepository {

  final OauthTokenRepository oauthTokenRepository;

  ResourceRepository({this.oauthTokenRepository});

  /// ## _apiAdaptor
  ///
  /// 현재 서버 api 연결 용으로 Dio Package 사용 중
  /// 나중에 네트워크 연결 라이브러리를 변경할 경우 아래 반환문 변경.
  Dio _apiAdaptor() {
    return DioCore().resource;
  }

  void setResourceLocale(Locale locale) {
    DioCore().setResourceLocale(locale);
  }

  /// ## get
  ///
  /// 데이터 로드
  Future<Response> get({
    @required String url
  }) => _apiAdaptor().get(url);

  /// ## post
  ///
  /// 데이터 입력
  Future<Response> post({
    @required String url,
    dynamic data
  }) => _apiAdaptor().post(url, data: data);

  /// ## patch
  ///
  /// 데이터 수정
  Future<Response> patch({
    @required String url,
    dynamic data
  }) => _apiAdaptor().patch(url, data: data);

  /// ## put **deprecated** patch 사용 권장
  @deprecated
  Future<Response> put({
    @required String url,
    dynamic data
  }) => _apiAdaptor().put(url, data: data);

  /// ## delete
  ///
  /// 데이터 삭제
  Future<Response> delete({
    @required String url,
  }) => _apiAdaptor().delete(url);
}