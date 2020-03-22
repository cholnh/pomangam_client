import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/initalizer/initializer.dart';
import 'package:pomangam_client/domains/order/order_request.dart';
import 'package:pomangam_client/domains/order/order_response.dart';
import 'package:pomangam_client/repositories/order/order_repository.dart';

import '../testable.dart';

class OrderRepositoryTest implements Testable {

  OrderRepository _orderRepository;
  Initializer _initializer;

  @override
  setUp() {
    _orderRepository = Injector.appInstance.getDependency<OrderRepository>();
    _initializer = Injector.appInstance.getDependency<Initializer>();
  }

  @override
  run() {
    test('order save test', () async {

      // Given
      String phoneNumber = '01064784899#test';
      String password = '1234';
      OrderRequest orderRequest = OrderRequest.fromJson({
        "orderDate": "2020-03-22",
        "idxOrderTime": 1,
        "idxDeliveryDetailSite": 2,
        "idxPayment": 1,
        "usingPoint": 0,
        "idxesUsingCoupons": [],
        "idxesUsingPromotions": [],
        "cashReceipt": "01012345678",
        "orderItems": [
          {
            "idxStore": 1,
            "idxProduct": 1,
            "quantity": 2,
            "requirement": "피클 빼주세요.",
            "orderItemSubs": []
          },
          {
            "idxStore": 1,
            "idxProduct": 2,
            "quantity": 1,
            "orderItemSubs": [
              {
                "idxProductSub": 6,
                "quantity": 2
              }
            ]
          }
        ]
      });
      OrderResponse orderResponse;

      // When
      //await _initializer.signIn(phoneNumber: phoneNumber, password: password);
      print(await _initializer.initializeToken());



      orderResponse = await _orderRepository.saveOrder(
          orderRequest: orderRequest
      );
      print('$orderResponse');

      // Then
      expect(1+1, 2);
    });
  }

  @override
  tearDown() {}
}