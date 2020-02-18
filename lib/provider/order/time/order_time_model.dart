import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domain/order/time/order_time.dart';
import 'package:pomangam_client/repository/order/time/order_time_repository.dart';

class OrderTimeModel with ChangeNotifier {
  OrderTimeRepository _orderTimeRepository;

  List<OrderTime> orderTimes = List();

  OrderTimeModel() {
    _orderTimeRepository = Injector.appInstance.getDependency<OrderTimeRepository>();
  }

  Future<void> fetch({
    bool forceUpdate = false,
    @required int didx
  }) async {
    if(!forceUpdate && orderTimes.length >= 0) return;

    List<OrderTime> fetched = [];
    try {
      fetched = await _orderTimeRepository.findByIdxDeliverySite(didx: didx);
    } catch (error) {
      print('[Debug] DeliverySiteModel.fetch Error - $error');
    }
    orderTimes.addAll(fetched);
    notifyListeners();
  }
}
