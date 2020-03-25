import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';

part 'payment.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Payment {

  PaymentType paymentType;

  CashReceipt cashReceipt;

  bool isPaymentAgree = false;

  DateTime paymentAgreeDate;

  Payment({
    this.paymentType, CashReceipt cashReceipt, this.isPaymentAgree,
    this.paymentAgreeDate
  }){
    this.cashReceipt = cashReceipt == null ? CashReceipt() : cashReceipt;
  }

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}