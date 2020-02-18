import 'package:flutter/foundation.dart';
import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/domain/common/page_request.dart';
import 'package:pomangam_client/domain/store/store.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';

class StoreRepository {

  final Api api; // 서버 연결용

  StoreRepository({this.api});

  Future<Store> findByIdx({
    @required int didx,
    @required int sidx
  }) async => Store.fromJson(
      (await api.get(url: '/dsites/$didx/stores/$sidx')).data);

  Future<List<StoreSummary>> findAll({
    @required int didx,
    @required PageRequest pageRequest
  }) async => StoreSummary.fromJsonList(
      (await api.get(url: '/dsites/$didx/stores/search/summaries')).data);

}