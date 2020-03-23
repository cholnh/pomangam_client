import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:provider/provider.dart';

Future<bool> deliveryDetailSiteDataInitialize({
  BuildContext context,
  int dIdx,
  int ddIdx
}) async {
  try {
    log('start deliveryDetailSiteData', name: 'deliveryDetailSiteDataInitialize', time: DateTime.now());

    // 배달지 상세 설정
    DeliveryDetailSiteModel detailSiteModel = Provider.of<DeliveryDetailSiteModel>(context, listen: false);
    await detailSiteModel.changeUserDeliveryDetailSiteByIdx(dIdx: dIdx, ddIdx: ddIdx);

    log('success', name: 'deliveryDetailSiteDataInitialize', time: DateTime.now());
    return true;
  } catch(error) {
    log('fail', name: 'deliveryDetailSiteDataInitialize', time: DateTime.now(), error: error);
    return false;
  }
}