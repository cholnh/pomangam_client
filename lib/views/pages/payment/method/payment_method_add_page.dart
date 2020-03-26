import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';

class PaymentMethodAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PaymentAppBar(
          context,
          title: '결제수단 추가',
          leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
        body: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
