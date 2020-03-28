import 'package:flutter/cupertino.dart';

class StoreViewModel with ChangeNotifier {
  bool isWidgetBuild = false;


  void widgetBuild({bool notify = false}) {
    if(isWidgetBuild) return;

    this.isWidgetBuild = true;
    if(notify) {
      notifyListeners();
    }
  }
}