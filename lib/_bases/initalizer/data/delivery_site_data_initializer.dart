import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:provider/provider.dart';

Future<bool> deliverySiteDataInitialize({
  BuildContext context,
  int dIdx
}) async {
  try {
    log('start deliverySiteData', name: 'deliverySiteDataInitialize', time: DateTime.now());

    // 배달지 설정
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    await deliverySiteModel.changeUserDeliverySiteByIdx(dIdx: dIdx);

    log('success', name: 'deliverySiteDataInitialize', time: DateTime.now());
    return true;
  } catch(error) {
    log('fail', name: 'deliverySiteDataInitialize', time: DateTime.now(), error: error);
    return false;
  }
}