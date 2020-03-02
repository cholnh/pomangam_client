import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domain/common/page_request.dart';
import 'package:pomangam_client/common/network/repository/authorization_repository.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/repository/store/store_repository.dart';

import '../testable.dart';

class StoreRepositoryTest implements Testable {

  StoreRepository _storeRepository;
  OauthTokenRepository _oauthTokenRepository;

  @override
  setUp() {
    Injector injector = Injector.appInstance;
    _storeRepository = injector.getDependency<StoreRepository>();
    _oauthTokenRepository = _oauthTokenRepository = injector.getDependency<OauthTokenRepository>();
  }

  @override
  run() {
    test('store summary test', () async {
      // Given
      List<StoreSummary> stores;
      int deliverySiteIdx = 1;
      int type = 0;
      PageRequest pageRequest = PageRequest(page: 0, size: 10);

      // When
      await _oauthTokenRepository.loadToken()
        ..saveToDioHeader()  // dio http header 추가
        ..saveToDisk();      // shared preference 저장

      stores = await _storeRepository.findOpeningStores(
        dIdx: deliverySiteIdx,
        pageRequest: pageRequest
      );
      print('$stores');

      // Then
      expect(1+1, 2);
    });
  }

  @override
  tearDown() {}
}