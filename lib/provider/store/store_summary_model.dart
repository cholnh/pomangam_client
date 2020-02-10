import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domain/common/page_request.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/repository/store/store_repository.dart';

class StoreSummaryModel with ChangeNotifier {

  StoreRepository _storeRepository;

  List<StoreSummary> stores = List();
  bool hasReachedMax = false;
  int curPage = 0;
  int size = 10;

  StoreSummaryModel() {
    _storeRepository = Injector.appInstance.getDependency<StoreRepository>();
  }

  Future fetch() async {
    if(hasReachedMax) return;

    List<StoreSummary> fetched = [];
    try {
      fetched = await _storeRepository.findAll(
          didx: 1,
          pageRequest: PageRequest(
              page: curPage++,
              size: size
          )
      );
    } catch(error) {
      print('[Debug] StoreSummaryModel.fetch Error - $error');
      hasReachedMax = true;
    }
    stores.addAll(fetched);

    int listCount = stores.length; //await _storeRepository.count();
    hasReachedMax = listCount <= stores.length;
    notifyListeners();
  }

}