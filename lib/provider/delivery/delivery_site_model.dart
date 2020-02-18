import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domain/delivery/delivery_site.dart';
import 'package:pomangam_client/repository/delivery/delivery_site_repository.dart';

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
    if(!forceUpdate && deliverySites.length >= 0) return;

    List<DeliverySite> fetched = [];
    try {
      fetched = await _deliverySiteRepository.findAll();
    } catch (error) {
      print('[Debug] DeliverySiteModel.fetch Error - $error');
    }
    deliverySites.addAll(fetched);
    notifyListeners();
  }

  Future<void> changeUserDeliverySite({
    @required int didx
  }) async {
    DeliverySite fetched;
    try {
      fetched = await _deliverySiteRepository.findByIdx(didx: didx);
    } catch (error) {
      print('[Debug] DeliverySiteModel.changeUserDeliverySite Error - $error');
    }
    userDeliverySite = fetched;
    notifyListeners();
  }
}
