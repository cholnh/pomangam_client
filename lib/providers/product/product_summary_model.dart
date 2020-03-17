import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domains/_bases/page_request.dart';
import 'package:pomangam_client/domains/product/product_summary.dart';
import 'package:pomangam_client/repositories/product/product_repository.dart';

class ProductSummaryModel with ChangeNotifier {

  ProductRepository _productRepository;

  List<ProductSummary> productSummaries = List();
  bool hasReachedMax = false;
  int curPage = 0;
  int size = 6;

  bool isFetching = false;

  ProductSummaryModel() {
    _productRepository = Injector.appInstance.getDependency<ProductRepository>();
  }

  Future<void> fetch({
    bool isForceUpdate = false,
    int dIdx,
    int sIdx,
    int cIdx = 0
  }) async {
    if(!isForceUpdate && hasReachedMax) return;
    hasReachedMax = true; // lock
    isFetching = true;

    List<ProductSummary> fetched = [];
    try {
      fetched = cIdx == 0
        ? await _productRepository.findByIdxStore(
            dIdx: dIdx,
            sIdx: sIdx,
            pageRequest: PageRequest(
                page: curPage++,
                size: size
            )
          )
        : await _productRepository.findByIdxProductCategory(
            dIdx: dIdx,
            sIdx: sIdx,
            cIdx: cIdx,
            pageRequest: PageRequest(
                page: curPage++,
                size: size
            )
          );
    } catch(error) {
      print('[Debug] StoreSummaryModel.fetch Error - $error');
      hasReachedMax = true;
      isFetching = false;
    }

    productSummaries.addAll(fetched);

    int listCount = cIdx == 0
      ? await _productRepository.countByIdxStore(
          dIdx: dIdx,
          sIdx: sIdx
        )
      : await _productRepository.countByIdxProductCategory(
          dIdx: dIdx,
          sIdx: sIdx,
          cIdx: cIdx
        );

    hasReachedMax = listCount <= productSummaries.length;
    isFetching = false;
    notifyListeners();
  }

  void clearWithNotify() {
    clear();
    notifyListeners();
  }

  void clear() {
    productSummaries.clear();
    hasReachedMax = false;
    curPage = 0;
    size = 6;
  }
}