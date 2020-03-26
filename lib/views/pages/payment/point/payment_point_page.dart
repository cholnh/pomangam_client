import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';

class PaymentPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PaymentAppBar(
          context,
          title: '포인트',
          leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Container(
            height: 300.0,
            color: subTextColor,
          ),
        )
      ),
    );
  }
}
