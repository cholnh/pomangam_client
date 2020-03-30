import 'package:flutter/foundation.dart';
import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/domains/_bases/page_request.dart';
import 'package:pomangam_client/domains/sort/sort_type.dart';
import 'package:pomangam_client/domains/store/store.dart';
import 'package:pomangam_client/domains/store/store_quantity_orderable.dart';
import 'package:pomangam_client/domains/store/store_summary.dart';

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
    @required PageRequest pageRequest,
    @required SortType sortType
  }) async => StoreSummary.fromJsonList((
      await api.get(
          url: '/dsites/$dIdx/stores?oIdx=$oIdx&oDate=$oDate&page=${pageRequest.page}&size=${pageRequest.size}&sortType=${sortType.toString().split('.').last}',
          fallBack: () => findOpeningStores(dIdx: dIdx, oIdx: oIdx, oDate: oDate, pageRequest: pageRequest, sortType: sortType)
      )).data);

  Future<int> count({
    @required int dIdx,
    @required int oIdx,
    @required String oDate,
  }) async => (await api.get(url: '/dsites/$dIdx/stores/search/count?oIdx=$oIdx&oDate=$oDate')).data;

  Future<List<StoreQuantityOrderable>> findQuantityOrderableByIdxes({
    @required int dIdx,
    @required int oIdx,
    @required String oDate,
    @required List<int> sIdxes,
  }) async => StoreQuantityOrderable.fromJsonList(
      (await api.get(url: '/dsites/$dIdx/stores?oIdx=$oIdx&oDate=$oDate&sIdxes=${sIdxes.toString().replaceAll('[', '').replaceAll(']', '')}')).data);

  Future<bool> likeToggle({
    @required int dIdx,
    @required int sIdx
  }) async => (await api.patch(url: '/dsites/$dIdx/stores/$sIdx/likes/toggle')).data;
}