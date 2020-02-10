import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/network/api/api.dart';

class InitializerModel with ChangeNotifier {

  Api _api;
  String kk = 'll';

  InitializerModel() {
    _api = Injector.appInstance.getDependency<Api>();
  }

  Future initialize({
    Locale locale
  }) async {
    await _api.initialize(locale: locale);  // resources 헤더에 locale 추가
  }

}