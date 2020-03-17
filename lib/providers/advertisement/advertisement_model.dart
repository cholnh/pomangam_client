import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domains/advertisement/advertisement.dart';
import 'package:pomangam_client/repositories/advertisement/advertisement_repository.dart';

class AdvertisementModel with ChangeNotifier {

  AdvertisementRepository _advertisementRepository;

  List<Advertisement> advertisements = List();

  bool isAdvertisementFetching = false;

  AdvertisementModel() {
    _advertisementRepository = Injector.appInstance.getDependency<AdvertisementRepository>();
  }

  Future<void> fetch({
    @required int dIdx
  }) async {
    isAdvertisementFetching = true;
    try {
      this.advertisements = await _advertisementRepository.findAll(dIdx: dIdx);
    } catch (error) {
      print('[Debug] AdvertisementModel.fetch Error - $error');
      this.isAdvertisementFetching = false;
    }
    this.isAdvertisementFetching = false;
    notifyListeners();
  }

  void clearWithNotify() {
    clear();
    notifyListeners();
  }

  void clear() {
    advertisements.clear();
  }
}