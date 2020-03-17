import 'package:flutter/foundation.dart';
import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/domains/product/sub/category/product_sub_category.dart';

class ProductSubRepository {

  final Api api; // 서버 연결용

  ProductSubRepository({this.api});

  Future<List<ProductSubCategory>> findByIdxProduct({
    @required int dIdx,
    @required int sIdx,
    @required int pIdx
  }) async => ProductSubCategory.fromJsonList(
      (await api.get(url: '/dsites/$dIdx/stores/$sIdx/products/$pIdx/subs')).data);

  Future<List<ProductSubCategory>> findByIdxProductSubCategory({
    @required int dIdx,
    @required int sIdx,
    @required int pIdx,
    @required int cIdx
  }) async => ProductSubCategory.fromJsonList(
      (await api.get(url: '/dsites/$dIdx/stores/$sIdx/products/$pIdx/subs?cIdx=$cIdx')).data);
}