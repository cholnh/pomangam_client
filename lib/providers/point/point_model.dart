import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domains/user/point_log/point_log.dart';
import 'package:pomangam_client/repositories/point/point_repository.dart';

class PointModel with ChangeNotifier {

  PointRepository _pointRepository;

  List<PointLog> pointLogs = List();

  bool isFetching = false;

  PointModel() {
    _pointRepository = Injector.appInstance.getDependency<PointRepository>();
  }

  Future<void> fetch() async {
    isFetching = true;
    try {
      this.pointLogs = await _pointRepository.findAll();
    } catch (error) {
      print('[Debug] DeliverySiteModel.fetch Error - $error');
      isFetching = false;
    }
    isFetching = false;
    notifyListeners();
  }
}