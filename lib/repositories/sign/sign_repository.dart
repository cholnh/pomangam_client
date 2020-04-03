import 'package:flutter/foundation.dart';
import 'package:pomangam_client/_bases/initalizer/initializer.dart';
import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/domains/user/auth_code_result.dart';
import 'package:pomangam_client/domains/user/phone_number.dart';
import 'package:pomangam_client/domains/user/user.dart';

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
      data: PhoneNumber(phoneNumber: phoneNumber).toJson())).data);

  Future<AuthCodeResult> requestAuthCodeForId({
    @required String phoneNumber
  }) async => AuthCodeResult.fromJson((await api.post(
      url: '/auth/code/id',
      data: PhoneNumber(phoneNumber: phoneNumber).toJson())).data);

  Future<bool> verifyAuthCodeForJoin({
    @required String phoneNumber, @required String code
  }) async => (await api.post(
      url: '/auth/check/join',
      data: PhoneNumber(phoneNumber: phoneNumber, code: code).toJson())).data;

  Future<bool> verifyAuthCodeForId({
    @required String phoneNumber, @required String code
  }) async => (await api.post(
      url: '/auth/check/id',
      data: PhoneNumber(phoneNumber: phoneNumber, code: code).toJson())).data;


  Future<User> postUser({
    @required User user
  }) async => User.fromJson((await api.post(
      url: '/users',
      data: user.toJson())).data);

  Future<bool> isExistByNickname({
    @required String nickname
  }) async => (await api.get(
      url: '/users/search/exist/nickname?nickname=$nickname')).data;

  Future<User> patchUser({
    @required User user
  }) async => User.fromJson((await api.patch(
      url: '/users/${user.phoneNumber}',
      data: user.toJson())).data);

  Future<User> signIn({
    @required String phoneNumber,
    @required String password
  }) => initializer.signIn(phoneNumber: phoneNumber, password: password);

  void signOut({bool trySignInGuest = true}) {
    initializer.signOut();
    if(trySignInGuest) {
      initializer.initializeToken();
    }
  }
}