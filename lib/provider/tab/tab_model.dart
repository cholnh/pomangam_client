import 'package:flutter/foundation.dart';
import 'package:pomangam_client/domain/tab/tab_menu.dart';

class TabModel with ChangeNotifier {

  TabMenu tab = TabMenu.more;

  change(TabMenu to) {
    tab = to;
    notifyListeners();
  }
}