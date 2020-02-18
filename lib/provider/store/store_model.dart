import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domain/store/store.dart';
import 'package:pomangam_client/repository/store/store_repository.dart';

class StoreModel with ChangeNotifier {

  Store store;
  StoreRepository _storeRepository;

  StoreModel() {
    _storeRepository = Injector.appInstance.getDependency<StoreRepository>();
  }

  void fetch({
    @required int didx,
    @required int sidx
  }) async {
    try {
      store = await _storeRepository.findByIdx(didx: didx, sidx: sidx);
    } catch (error) {
      print('[Debug] StoreModel.fetch Error - $error');
    }
    notifyListeners();
  }

}