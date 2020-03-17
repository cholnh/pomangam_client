import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/repositories/order/order_repository.dart';

class OrderModel with ChangeNotifier {
  OrderRepository _orderRepository;

  OrderModel() {
    _orderRepository = Injector.appInstance.getDependency<OrderRepository>();
  }

}
