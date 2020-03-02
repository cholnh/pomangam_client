import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomangam_client/common/initalizer/initializer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client/common/key/shared_preference_key.dart' as s;

import '../testable.dart';

class ModelTest implements Testable {

  Initializer _initializerModel = Initializer();

  @override
  setUp() {
  }

  @override
  run() {
    test('model api test', () async {
      // Given
      SharedPreferences.setMockInitialValues({
        s.idxFcmToken: 12,
        s.fcmToken: '!@#@# token #@#@!'
      });

      // When
      //bool hasFcmToken = await _initializerModel.hasFcmToken();

      // Then
      //expect(hasFcmToken, true);
    });
  }

  @override
  tearDown() {
  }

}