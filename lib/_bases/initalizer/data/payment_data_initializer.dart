import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:provider/provider.dart';

Future<bool> paymentDataInitialize({
  BuildContext context
}) async {
  try {
    log('start paymentData', name: 'paymentDataInitialize', time: DateTime.now());

    // 결제수단
    PaymentModel paymentModel = Provider.of<PaymentModel>(context, listen: false);
    await paymentModel.loadPayment();

    log('success', name: 'paymentDataInitialize', time: DateTime.now());
    return true;
  } catch(error) {
    log('fail', name: 'paymentDataInitialize', time: DateTime.now(), error: error);
    return false;
  }
}