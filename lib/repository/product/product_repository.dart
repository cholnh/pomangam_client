import 'package:flutter/foundation.dart';
import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/domain/common/page_request.dart';
import 'package:pomangam_client/domain/product/product.dart';
import 'package:pomangam_client/domain/product/product_summary.dart';

class ProductRepository {

  final Api api; // 서버 연결용

  ProductRepository({this.api});

  Future<Product> findByIdx({
    @required int dIdx,
    @required int sIdx,
    @required int pIdx
  }) async => Product.fromJson(
      (await api.get(url: '/dsites/$dIdx/stores/$sIdx/products/$pIdx')).data);

  Future<List<ProductSummary>> findByIdxStore({
    @required int dIdx,
    @required int sIdx,
    @required PageRequest pageRequest
  }) async => ProductSummary.fromJsonList(
      (await api.get(url: '/dsites/$dIdx/stores/$sIdx/products?page=${pageRequest.page}&size=${pageRequest.size}')).data);

  Future<int> countByIdxStore({
    @required int dIdx,
    @required int sIdx
  }) async => (await api.get(url: '/dsites/$dIdx/stores/$sIdx/products/search/count')).data;

  Future<List<ProductSummary>> findByIdxProductCategory({
    @required int dIdx,
    @required int sIdx,
    @required int cIdx,
    @required PageRequest pageRequest
  }) async => ProductSummary.fromJsonList(
      (await api.get(url: '/dsites/$dIdx/stores/$sIdx/products?cIdx=$cIdx&page=${pageRequest.page}&size=${pageRequest.size}')).data);

  Future<int> countByIdxProductCategory({
    @required int dIdx,
    @required int sIdx,
    @required int cIdx
  }) async => (await api.get(url: '/dsites/$dIdx/stores/$sIdx/products/search/count?cIdx=$cIdx')).data;
}