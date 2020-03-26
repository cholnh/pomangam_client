import 'package:flutter/material.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';

class PaymentMethodCommonTypeWidget extends StatelessWidget {

  final Function onSelected;
  final bool isSelected;
  final PaymentType paymentType;

  PaymentMethodCommonTypeWidget({this.onSelected, this.isSelected, this.paymentType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Material(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
              leading: Radio(value: isSelected, groupValue: true),
              title:  Text(
                '${convertPaymentTypeToText(paymentType)}',
                style: TextStyle(fontSize: 14.0, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)
              ),
            ),
            Divider(height: 0.5)
          ],
        ),
      ),
    );
  }
}
