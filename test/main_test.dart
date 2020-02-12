// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/di/injector_register.dart';

import 'package:pomangam_client/main.dart';
import 'package:pomangam_client/repository/store/store_repository.dart';

import 'domain/domain_test.dart';
import 'provider/model_test.dart';
import 'repository/repository_test.dart';
import 'repository/store_repository_test.dart';
import 'testable.dart';

void main() {

  InjectorRegister.register();
  TestWidgetsFlutterBinding.ensureInitialized();

  List<Testable>.from([
    ModelTest(),
    //DomainTest(),
    //StoreRepositoryTest(),

  ]).forEach((cls) {
    cls.setUp();
    cls.run();
    cls.tearDown();
  });
}
