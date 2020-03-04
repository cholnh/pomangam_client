import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domain/store/store.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/repository/store/store_repository.dart';

class StoreModel with ChangeNotifier {

  Store store;
  StoreSummary summary;
  StoreRepository _storeRepository;

  bool isStoreFetched = false;

  StoreModel() {
    _storeRepository = Injector.appInstance.getDependency<StoreRepository>();
  }

  void fetch({
    @required int dIdx,
    @required int sIdx
  }) async {
    try {
      this.store = await _storeRepository.findByIdx(dIdx: dIdx, sIdx: sIdx);
      this.isStoreFetched = true;
    } catch (error) {
      print('[Debug] StoreModel.fetch Error - $error');
    }
    notifyListeners();
  }

  void changeIsStoreFetched(bool tf) {
    this.isStoreFetched = tf;
    notifyListeners();
  }
}