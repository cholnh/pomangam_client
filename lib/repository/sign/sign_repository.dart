import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/initalizer/initializer.dart';
import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/domain/sign/auth_code_result.dart';
import 'package:pomangam_client/domain/sign/phone_number.dart';
import 'package:pomangam_client/domain/sign/user.dart';

class SignRepository {

  final Api api; // 서버 연결용
  final Initializer initializer;

  SignRepository({this.api, this.initializer});

  Future<bool> verifyPhoneNumber({
    @required String phoneNumber
  }) async => (await api.get(
      url: '/users/search/exist/phone?phn=$phoneNumber')).data;

  Future<AuthCodeResult> requestAuthCodeForJoin({
    @required String phoneNumber
  }) async => AuthCodeResult.fromJson((await api.post(
      url: '/auth/code/join',
      jsonData: PhoneNumber(phoneNumber: phoneNumber).toJson())).data);

  Future<bool> verifyAuthCodeForJoin({
    @required String phoneNumber, @required String code
  }) async => (await api.post(
      url: '/auth/check/join',
      jsonData: PhoneNumber(phoneNumber: phoneNumber, code: code).toJson())).data;

  Future<User> postUser({
    @required User user
  }) async => User.fromJson((await api.post(
      url: '/users',
      jsonData: user.toJson())).data);

  Future<bool> isExistByNickname({
    @required String nickname
  }) async => (await api.get(
      url: '/users/search/exist/nickname?nickname=$nickname')).data;

  Future<User> patchUser({
    @required User user
  }) async => User.fromJson((await api.patch(
      url: '/users/${user.phoneNumber}',
      jsonData: user.toJson())).data);

  Future<User> signIn({
    @required String phoneNumber,
    @required String password
  }) => initializer.initializeToken(phoneNumber: phoneNumber, password: password);

  void signOut() => api.signOut();
}