import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domain/deliverysite/detail/delivery_detail_site.dart';
import 'package:pomangam_client/repository/delivery/detail/delivery_detail_site_repository.dart';

class DeliveryDetailSiteModel with ChangeNotifier {
  DeliveryDetailSiteRepository _deliveryDetailSiteRepository;

  List<DeliveryDetailSite> deliveryDetailSites = List();
  DeliveryDetailSite userDeliveryDetailSite;

  DeliveryDetailSiteModel() {
    _deliveryDetailSiteRepository = Injector.appInstance.getDependency<DeliveryDetailSiteRepository>();
  }

  Future<void> fetch({
    bool forceUpdate = false,
    @required int dIdx
  }) async {
    if(!forceUpdate && deliveryDetailSites.length > 0) return;

    List<DeliveryDetailSite> fetched = [];
    try {
      fetched = await _deliveryDetailSiteRepository.findAll(dIdx: dIdx);
    } catch (error) {
      print('[Debug] DeliveryDetailSiteModel.fetch Error - $error');
    }
    deliveryDetailSites.addAll(fetched);
    notifyListeners();
  }

  Future<void> changeUserDeliveryDetailSite({
    @required int dIdx,
    @required int ddIdx
  }) async {
    DeliveryDetailSite fetched;
    try {
      fetched = await _deliveryDetailSiteRepository.findByIdx(dIdx: dIdx, ddIdx: ddIdx);
    } catch (error) {
      print('[Debug] DeliveryDetailSiteModel.changeUserDeliveryDetailSite Error - $error');
    }
    userDeliveryDetailSite = fetched;
    notifyListeners();
  }
}
