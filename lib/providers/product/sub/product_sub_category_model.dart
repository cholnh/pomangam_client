import 'package:flutter/cupertino.dart';

class ProductSubCategoryModel with ChangeNotifier {
  int idxSelectedCategory = 0;
  int idxProductSubCategory = 0;

  void changeIdxSelectedCategory(int idxSelectedCategory) {
    this.idxSelectedCategory = idxSelectedCategory;
    notifyListeners();
  }

  void changeIdxProductSubCategory(int idxProductSubCategory) {
    this.idxProductSubCategory = idxProductSubCategory;
    notifyListeners();
  }

  void clearWithNotifier() {
    this.clear();
    notifyListeners();
  }

  void clear() {
    this.idxSelectedCategory = 0;
    this.idxProductSubCategory = 0;
  }
}