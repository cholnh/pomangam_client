import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domains/deliverysite/delivery_site.dart';
import 'package:pomangam_client/repositories/delivery/delivery_site_repository.dart';

class DeliverySiteModel with ChangeNotifier {
  DeliverySiteRepository _deliverySiteRepository;

  List<DeliverySite> deliverySites = List();
  DeliverySite userDeliverySite;

  DeliverySiteModel() {
    _deliverySiteRepository = Injector.appInstance.getDependency<DeliverySiteRepository>();
  }

  Future<void> fetch({
    bool forceUpdate = false
  }) async {
    if(!forceUpdate && deliverySites.length > 0) return;

    List<DeliverySite> fetched = [];
    try {
      fetched = await _deliverySiteRepository.findAll();
    } catch (error) {
      print('[Debug] DeliverySiteModel.fetch Error - $error');
    }
    deliverySites.addAll(fetched);
    notifyListeners();
  }

  Future<void> changeUserDeliverySiteByIdx({
    @required int dIdx
  }) async {
    DeliverySite fetched;
    try {
      fetched = await _deliverySiteRepository.findByIdx(dIdx: dIdx);
    } catch (error) {
      print('[Debug] DeliverySiteModel.changeUserDeliverySite Error - $error');
    }
    changeUserDeliverySite(fetched);
  }

  void changeUserDeliverySite(DeliverySite deliverySite) {
    this.userDeliverySite = deliverySite;
    notifyListeners();
  }
}
