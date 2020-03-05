import 'package:flutter/cupertino.dart';

class StoreProductCategoryModel with ChangeNotifier {
  int idxSelectedCategory = 0;
  int idxProductCategory = 0;

  void changeIdxSelectedCategory(int idxSelectedCategory) {
    this.idxSelectedCategory = idxSelectedCategory;
    notifyListeners();
  }
}