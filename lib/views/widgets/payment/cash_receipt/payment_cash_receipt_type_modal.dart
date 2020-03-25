import 'package:flutter/material.dart';
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client/views/widgets/payment/cash_receipt/payment_cash_receipt_type_modal_item_widget.dart';

class PaymentCashReceiptTypeModal extends StatelessWidget {

  final CashReceiptType cashReceiptType;
  final Function(CashReceiptType) onSelected;

  PaymentCashReceiptTypeModal({this.cashReceiptType, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                    '현금영수증 종류',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              Divider(height: 0.0, thickness: 8.0, color: Colors.black.withOpacity(0.03)),
              PaymentCashReceiptTypeModalItemWidget(
                type: CashReceiptType.PERSONAL_PHONE_NUMBER,
                isSelected: cashReceiptType == CashReceiptType.PERSONAL_PHONE_NUMBER,
                onSelected: onSelected,
              ),
              const Divider(height: 0.1),
              PaymentCashReceiptTypeModalItemWidget(
                type: CashReceiptType.PERSONAL_CARD_NUMBER,
                isSelected: cashReceiptType == CashReceiptType.PERSONAL_CARD_NUMBER,
                onSelected: onSelected,
              ),
              const Divider(height: 0.1),
              PaymentCashReceiptTypeModalItemWidget(
                type: CashReceiptType.BUSINESS_REGISTRATION_NUMBER,
                isSelected: cashReceiptType == CashReceiptType.BUSINESS_REGISTRATION_NUMBER,
                onSelected: onSelected,
              ),
              const Divider(height: 0.1),
              PaymentCashReceiptTypeModalItemWidget(
                type: CashReceiptType.BUSINESS_CARD_NUMBER,
                isSelected: cashReceiptType == CashReceiptType.BUSINESS_CARD_NUMBER,
                onSelected: onSelected,
              ),
              const Divider(height: 0.1),
            ],
          )
        ],
      ),
    );
  }
}
