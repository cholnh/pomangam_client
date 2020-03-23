import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:provider/provider.dart';

Future<bool> cartDataInitialize({
  BuildContext context
}) async {
  try {
    log('start cartData', name: 'cartDataInitialize', time: DateTime.now());

    // 카트 초기화
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    DeliveryDetailSiteModel detailSiteModel = Provider.of<DeliveryDetailSiteModel>(context, listen: false);
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.cart
      ..orderDate = orderTimeModel.userOrderDate
      ..orderTime = orderTimeModel.userOrderTime
      ..detail = detailSiteModel.userDeliveryDetailSite;

    log('success', name: 'cartDataInitialize', time: DateTime.now());
    return true;
  } catch(error) {
    log('fail', name: 'cartDataInitialize', time: DateTime.now(), error: error);
    return false;
  }
}