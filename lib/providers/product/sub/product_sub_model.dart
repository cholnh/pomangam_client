//import 'package:flutter/cupertino.dart';
//import 'package:injector/injector.dart';
//import 'package:pomangam_client/domains/product/sub/product_sub.dart';
//import 'package:pomangam_client/repositories/product/sub/product_sub_repository.dart';
//
//class ProductSubModel with ChangeNotifier {
//
//  ProductSubRepository _productSubRepository;
//
//  List<ProductSub> productSubs;
//
//  bool isProductSubsFetched = false;
//  bool isProductSubsFetching = false;
//
//  ProductSubModel() {
//    _productSubRepository = Injector.appInstance.getDependency<ProductSubRepository>();
//  }
//
//  Future<void> fetch({
//    @required int dIdx,
//    @required int sIdx,
//    @required int pIdx,
//    int cIdx = 0
//  }) async {
//    isProductSubsFetching = true;
//    try {
//      this.productSubs = cIdx == 0
//        ? await _productSubRepository.findByIdxProduct(dIdx: dIdx, sIdx: sIdx, pIdx: pIdx)
//        : await _productSubRepository.findByIdxProductSubCategory(dIdx: dIdx, sIdx: sIdx, pIdx: pIdx, cIdx: cIdx);
//
//      isProductSubsFetched = true;
//    } catch (error) {
//      print('[Debug] ProductSubModel.fetch Error - $error');
//      isProductSubsFetching = false;
//    }
//    isProductSubsFetching = false;
//    notifyListeners();
//  }
//
//  void changeProductSubs(List<ProductSub> productSubs) {
//    this.productSubs = productSubs;
//    notifyListeners();
//  }
//
//  void clearWithNotify() {
//    clear();
//    notifyListeners();
//  }
//
//  void clear() {
//    productSubs?.clear();
//    isProductSubsFetched = false;
//  }
//}