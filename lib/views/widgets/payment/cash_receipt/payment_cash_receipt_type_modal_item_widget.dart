import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt_type.dart';

class PaymentCashReceiptTypeModalItemWidget extends StatelessWidget {

  final CashReceiptType type;
  final bool isSelected;
  final Function(CashReceiptType) onSelected;

  PaymentCashReceiptTypeModalItemWidget({this.type, this.isSelected = false, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        title: isSelected
          ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('${convertCashReceiptTypeToText(type)}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: primaryColor)),
              const Padding(padding: EdgeInsets.all(3)),
              const Icon(Icons.check, color: primaryColor, size: 18.0)
            ],
          )
          : Text('${convertCashReceiptTypeToText(type)}', style: TextStyle(fontSize: 14.0)),
        onTap: () => onSelected(type),
      ),
    );
  }
}
