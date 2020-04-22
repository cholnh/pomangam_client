import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domains/order/order_request.dart';
import 'package:pomangam_client/domains/order/order_response.dart';
import 'package:pomangam_client/repositories/order/order_repository.dart';

class OrderModel with ChangeNotifier {
  OrderRepository _orderRepository;

  OrderResponse orderResponse;
  bool isSaving = false;
  bool isVerify = false;
  bool isValidOrder = false;

  OrderModel() {
    _orderRepository = Injector.appInstance.getDependency<OrderRepository>();
  }

  Future<OrderResponse> saveOrder({
    @required OrderRequest orderRequest
  }) async {
    this.isSaving = true;
    this.orderResponse = null;
    notifyListeners();

    try {
      this.orderResponse = await _orderRepository.saveOrder(orderRequest: orderRequest);
    } catch (error) {
      print('[Debug] OrderModel.saveOrder Error - $error');
      this.isSaving = false;
    }
    this.isSaving = false;
    notifyListeners();
    return this.orderResponse;
  }

  Future<void> verify({
    @required int oIdx
  }) async {
    this.isVerify = true;
    try {
      this.isValidOrder = await _orderRepository.verify(oIdx: oIdx);
    } catch (error) {
      print('[Debug] OrderModel.verify Error - $error');
      this.isVerify = false;
    }
    this.isVerify = false;
    notifyListeners();
  }
}
