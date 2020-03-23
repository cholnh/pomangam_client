import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:provider/provider.dart';

Future<bool> orderTimeDataInitialize({
  BuildContext context,
  int dIdx
}) async {
  try {
    log('start orderTimeData', name: 'orderTimeDataInitialize', time: DateTime.now());

    // 배달가능시간 설정
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    await orderTimeModel.fetch(forceUpdate: true, dIdx: dIdx);

    log('success', name: 'orderTimeDataInitialize', time: DateTime.now());
    return true;
  } catch(error) {
    log('fail', name: 'orderTimeDataInitialize', time: DateTime.now(), error: error);
    return false;
  }
}