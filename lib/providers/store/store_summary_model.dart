import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/domains/_bases/page_request.dart';
import 'package:pomangam_client/domains/store/store_quantity_orderable.dart';
import 'package:pomangam_client/domains/store/store_summary.dart';
import 'package:pomangam_client/repositories/store/store_repository.dart';

class StoreSummaryModel with ChangeNotifier {

  StoreRepository _storeRepository;

  List<StoreSummary> stores = List();
  bool hasReachedMax = false;
  int curPage = 0;
  int size = 10;

  bool isFetching = false;

  StoreSummaryModel() {
    _storeRepository = Injector.appInstance.getDependency<StoreRepository>();
  }

  Future<void> fetch({
    bool isForceUpdate = false,
    @required int dIdx,
    @required int oIdx,
    @required DateTime oDate
  }) async {
    if(!isForceUpdate && hasReachedMax) return;
    hasReachedMax = true; // lock
    isFetching = true;

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
      fetched.shuffle();
    } catch(error) {
      print('[Debug] StoreSummaryModel.fetch Error - $error');
      hasReachedMax = true;
      isFetching = false;
    }
    stores.addAll(fetched);

    int listCount = await _storeRepository.count(
      dIdx: dIdx,
      oIdx: oIdx,
      oDate: DateFormat('yyyy-MM-dd').format(oDate),
    );

    hasReachedMax = listCount <= stores.length;
    isFetching = false;
    notifyListeners();
  }

  Future<List<StoreQuantityOrderable>> fetchQuantityOrderable({
    @required int dIdx,
    @required int oIdx,
    @required DateTime oDate
  }) async {
    List<StoreQuantityOrderable> quantities = [];
    try {
      quantities = await _storeRepository.findQuantityOrderableByIdxes(
        dIdx: dIdx,
        oIdx: oIdx,
        oDate: DateFormat('yyyy-MM-dd').format(oDate),
        sIdxes: stores.map((store) => store.idx).toList()
      );
    } catch(error) {
      print('[Debug] StoreSummaryModel.fetchQuantityOrderable Error - $error');
    }
    return quantities;
  }

  void setQuantityOrderable(Object quantities) async {
    if(quantities is Future<List<StoreQuantityOrderable>>) {
      for(StoreQuantityOrderable quantity in await quantities) {
        for(StoreSummary summary in this.stores) {
          if(summary.idx == quantity.idx) {
            summary.quantityOrderable = quantity.quantityOrderable;
            break;
          }
        }
      }
      notifyListeners();
    }
  }

  void clearWithNotify() {
    clear();
    notifyListeners();
  }

  void clear() {
    stores.clear();
    hasReachedMax = false;
    curPage = 0;
    size = 10;
  }
}