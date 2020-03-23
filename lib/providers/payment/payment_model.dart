import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client/domains/payment/payment.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client/_bases/key/shared_preference_key.dart' as s;

class PaymentModel with ChangeNotifier {

  Payment payment = Payment();

  bool isReadyPayment() {
    return payment?.paymentType != null && payment.isPaymentAgree;
  }

  Widget iconPaymentType() {
    if(payment?.paymentType != null) {
      switch(payment.paymentType) {
        case PaymentType.CREDIT_CARD:
          return Icon(Icons.credit_card, size: 14.0);
        case PaymentType.PHONE:
          return Icon(Icons.phone_iphone, size: 14.0);
        case PaymentType.V_BANK:
          return Icon(Icons.format_bold, size: 14.0);
      }
    }
    return Icon(Icons.error, size: 16.0, color: primaryColor);
  }

  String textPaymentType() {
    if(payment?.paymentType != null) {
      switch(payment.paymentType) {
        case PaymentType.CREDIT_CARD:
          return '신용/체크 카드';
        case PaymentType.PHONE:
          return '핸드폰 결제';
        case PaymentType.V_BANK:
          return '가상계좌';
      }
    }
    return '미등록';
  }

  String textCashReceiptType() {
    if(payment?.cashReceipt?.cashReceiptType != null) {
      switch(payment.cashReceipt.cashReceiptType) {
        case CashReceiptType.PERSONAL:
          return '개인소득공제';
        case CashReceiptType.BUSINESS:
          return '사업자증빙';
      }
    }
    return '미등록';
  }

  Future<void> loadPayment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    this.payment
    ..paymentType = convertPaymentType(pref.getString(s.paymentType))
    ..cashReceipt.cashReceiptNumber = pref.getString(s.cashReceiptNumber)
    ..cashReceipt.cashReceiptType = convertCashReceiptType(pref.getString(s.paymentType))
    ..isPaymentAgree = pref.getBool(s.isPaymentAgree)
    ..paymentAgreeDate = DateTime.parse(pref.getString(s.paymentAgreeDate));
  }

  Future<void> savePaymentType(
    PaymentType paymentType,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.paymentType, paymentType.toString());
    this.payment.paymentType = paymentType;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> saveCashReceiptNumber(
    String cashReceiptNumber,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.cashReceiptNumber, cashReceiptNumber);
    this.payment.cashReceipt.cashReceiptNumber = cashReceiptNumber;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> saveCashReceiptType(
    CashReceiptType cashReceiptType,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.cashReceiptType, cashReceiptType.toString());
    this.payment.cashReceipt.cashReceiptType = cashReceiptType;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> saveIsPaymentAgree(
    bool isPaymentAgree,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(s.isPaymentAgree, isPaymentAgree);
    this.payment.isPaymentAgree = isPaymentAgree;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> savePaymentAgreeDate(
    DateTime paymentAgreeDate,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.paymentAgreeDate, paymentAgreeDate?.toIso8601String());
    this.payment.paymentAgreeDate = paymentAgreeDate;
    if(notify) {
      notifyListeners();
    }
  }
}