import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt_type.dart';

part 'cash_receipt.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class CashReceipt {

  bool isIssueCashReceipt = false;

  String cashReceiptNumber;

  CashReceiptType cashReceiptType;

  CashReceipt({this.cashReceiptNumber, CashReceiptType cashReceiptType}) {
    this.cashReceiptType = cashReceiptType == null ? CashReceiptType.PERSONAL_PHONE_NUMBER : cashReceiptType;
  }

  factory CashReceipt.fromJson(Map<String, dynamic> json) => _$CashReceiptFromJson(json);
  Map<String, dynamic> toJson() => _$CashReceiptToJson(this);
}