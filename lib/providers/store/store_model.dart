import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domains/store/store.dart';
import 'package:pomangam_client/domains/store/store_summary.dart';
import 'package:pomangam_client/repositories/store/store_repository.dart';

class StoreModel with ChangeNotifier {

  StoreRepository _storeRepository;

  Store store;
  StoreSummary summary;

  bool isStoreFetched = false;
  bool isStoreDescriptionOpened = false;
  bool isProcessingLikeToggle = false;

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

  void likeToggle({
    @required int dIdx,
    @required int sIdx
  }) async {
    if(isProcessingLikeToggle) return;
    isProcessingLikeToggle = true;
    try {
      bool isLike = await _storeRepository.likeToggle(dIdx: dIdx, sIdx: sIdx);
      store.isLike = isLike;
      notifyListeners();
    } catch (error) {
      print('[Debug] StoreModel.likeToggle Error - $error');
    } finally {
      isProcessingLikeToggle = false;
    }
  }

  void changeIsStoreFetched(bool tf) {
    this.isStoreFetched = tf;
    notifyListeners();
  }

  void toggleIsStoreDescriptionOpened() {
    this.isStoreDescriptionOpened = !this.isStoreDescriptionOpened;
    notifyListeners();
  }
}