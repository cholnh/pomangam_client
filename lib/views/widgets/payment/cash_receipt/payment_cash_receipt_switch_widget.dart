import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class PaymentCashReceiptSwitchWidget extends StatelessWidget {

  final Function onSelected;
  final bool isIssueCashReceipt;

  PaymentCashReceiptSwitchWidget({
    this.onSelected,
    this.isIssueCashReceipt
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Material(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('현금영수증 발급', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Switch(
                  value: isIssueCashReceipt,
                  inactiveTrackColor: isIssueCashReceipt ? primaryColor : subTextColor,
                  inactiveThumbColor: Colors.white,
                )
              ],
            ),
            Divider(height: 10.0)
          ],
        ),
      ),
    );
  }
}
