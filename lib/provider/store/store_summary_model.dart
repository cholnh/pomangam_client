import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
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

  void clear() {
    stores.clear();
    hasReachedMax = false;
    curPage = 0;
    size = 10;
    notifyListeners();
  }

  Future fetch({bool isForceUpdate = false, int dIdx, int oIdx, DateTime oDate}) async {
    if(!isForceUpdate && hasReachedMax) return;
    hasReachedMax = true; // lock

    List<StoreSummary> fetched = [];
    try {
      fetched = await _storeRepository.findOpeningStores(
          dIdx: dIdx,
          oIdx: oIdx,
          oDate: DateFormat('yyyy-MM-dd').format(oDate),
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

    int listCount = await _storeRepository.count(
      dIdx: dIdx,
      oIdx: oIdx,
      oDate: DateFormat('yyyy-MM-dd').format(oDate),
    );

    hasReachedMax = listCount <= stores.length;
    notifyListeners();
  }
}