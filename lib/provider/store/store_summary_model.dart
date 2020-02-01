import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/network/domain/page_request.dart';
import 'package:pomangam_client/common/network/exception/oauth_exception.dart';
import 'package:pomangam_client/domain/store/store_summary_entity.dart';
import 'package:pomangam_client/domain/temp/todo_dto.dart';
import 'package:pomangam_client/repository/store/store_repository.dart';
import 'package:pomangam_client/repository/temp/todo_repository.dart';

class StoreSummaryModel with ChangeNotifier {

  List<StoreSummaryEntity> stores = List();
  bool hasReachedMax = false;
  StoreRepository _storeRepository;
  int curPage = 0;
  int size = 10;


  StoreSummaryModel() {
    _storeRepository = Injector.appInstance.getDependency<StoreRepository>();
  }

  fetch({Function networkErrorHandler}) async {
    if(hasReachedMax) return;

    try {
      stores.addAll(
        await _storeRepository.findByType(
          deliverySiteIdx: 1,
          type: 1,
          pageRequest: PageRequest(
            page: curPage++,
            size: size
          )
        )
      );
    } on OauthNetworkException catch (error) {
      print('[Debug] StoreSummaryModel.fetch Error - $error');
    }

    int listCount = stores.length;//await _storeRepository.count();
    hasReachedMax = listCount <= stores.length;
    notifyListeners();
  }

}