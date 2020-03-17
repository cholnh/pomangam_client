import 'package:flutter/cupertino.dart';

class StoreProductCategoryModel with ChangeNotifier {
  int idxSelectedCategory = 0;
  int idxProductCategory = 0;

  void changeIdxSelectedCategory(int idxSelectedCategory) {
    this.idxSelectedCategory = idxSelectedCategory;
    notifyListeners();
  }

  void clearWithNotifier() {
    this.clear();
    notifyListeners();
  }

  void clear() {
    this.idxSelectedCategory = 0;
    this.idxProductCategory = 0;
  }
}