import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domain/product/product.dart';
import 'package:pomangam_client/domain/product/product_summary.dart';
import 'package:pomangam_client/repository/product/product_repository.dart';

class ProductModel with ChangeNotifier {

  ProductRepository _productRepository;

  Product product;
  ProductSummary summary;

  bool isProductFetched = false;
  bool isProcessingLikeToggle = false;

  ProductModel() {
    _productRepository = Injector.appInstance.getDependency<ProductRepository>();
  }

  void fetch({
    @required int dIdx,
    @required int sIdx,
    @required int pIdx
  }) async {
    try {
      this.product = await _productRepository.findByIdx(dIdx: dIdx, sIdx: sIdx, pIdx: pIdx);
      this.isProductFetched = true;
    } catch (error) {
      print('[Debug] ProductModel.fetch Error - $error');
    }
    notifyListeners();
  }

  void likeToggle({
    @required int dIdx,
    @required int sIdx,
    @required int pIdx
  }) async {
    if(isProcessingLikeToggle) return;
    isProcessingLikeToggle = true;
    try {
      bool isLike = await _productRepository.likeToggle(dIdx: dIdx, sIdx: sIdx, pIdx: pIdx);
      product.isLike = isLike;
      notifyListeners();
    } catch (error) {
      print('[Debug] ProductModel.likeToggle Error - $error');
    } finally {
      isProcessingLikeToggle = false;
    }
  }

  void changeIsProductFetched(bool tf) {
    this.isProductFetched = tf;
    notifyListeners();
  }
}