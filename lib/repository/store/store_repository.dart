import 'package:flutter/foundation.dart';
import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/domain/common/page_request.dart';
import 'package:pomangam_client/domain/store/store.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';

class StoreRepository {

  final Api api; // 서버 연결용

  StoreRepository({this.api});

  Future<Store> findByIdx({
    @required int dIdx,
    @required int sIdx
  }) async => Store.fromJson(
      (await api.get(url: '/dsites/$dIdx/stores/$sIdx')).data);

  Future<List<StoreSummary>> findOpeningStores({
    @required int dIdx,
    @required int oIdx,
    @required String oDate,
    @required PageRequest pageRequest
  }) async => StoreSummary.fromJsonList(
      (await api.get(url: '/dsites/$dIdx/stores?oIdx=$oIdx&oDate=$oDate&page=${pageRequest.page}&size=${pageRequest.size}')).data);

  Future<int> count({
    @required int dIdx,
    @required int oIdx,
    @required String oDate,
  }) async => (await api.get(url: '/dsites/$dIdx/stores/search/count?oIdx=$oIdx&oDate=$oDate')).data;
}