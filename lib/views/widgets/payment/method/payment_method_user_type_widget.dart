import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';

class PaymentMethodUserTypeWidget extends StatelessWidget {

  final String bankName;
  final String bankNumberPreview;
  final Function onSelected;
  final bool isSelected;
  final PaymentType paymentType;

  PaymentMethodUserTypeWidget({this.bankName, this.bankNumberPreview, this.onSelected, this.isSelected, this.paymentType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Material(
        child: Column(
          children: <Widget>[
            Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                leading: Radio(value: isSelected, groupValue: true),
                title:  Text(
                  '$bankName (${convertPaymentTypeToText(paymentType)})',
                  style: TextStyle(fontSize: 14.0, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)
                ),
                subtitle: Text('$bankNumberPreview', style: TextStyle(fontSize: 12.0, color: subTextColor)),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  iconWidget: Text('삭제', style: TextStyle(fontSize: 14.0, color: backgroundColor)),
                  color: primaryColor,
                  onTap: () => print('Delete'),
                ),
              ],
            ),
            Divider(height: 0.5)
          ],
        ),
      ),
    );
  }
}
