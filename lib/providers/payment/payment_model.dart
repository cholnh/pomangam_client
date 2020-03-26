import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/key/shared_preference_key.dart' as s;
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client/domains/payment/payment.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentModel with ChangeNotifier {

  Payment payment = Payment();

  bool isReadyPayment() {
    return payment?.paymentType != null && payment.isPaymentAgree;
  }

  Future<void> loadPayment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    this.payment
    ..paymentType = pref.getString(s.paymentType) != null ? convertTextToPaymentType(pref.getString(s.paymentType)) : PaymentType.COMMON_CREDIT_CARD
    ..cashReceipt.isIssueCashReceipt = pref.getBool(s.isIssueCashReceipt) ?? false
    ..cashReceipt.cashReceiptNumber = pref.getString(s.cashReceiptNumber)
    ..cashReceipt.cashReceiptType = pref.getString(s.cashReceiptType) != null ? convertTextToCashReceiptType(pref.getString(s.cashReceiptType)) : CashReceiptType.PERSONAL_CARD_NUMBER
    ..isPaymentAgree = pref.getBool(s.isPaymentAgree) ?? false
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

  Future<void> saveIsIssueCashReceipt(
      bool isIssueCashReceipt,
      {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(s.isIssueCashReceipt, isIssueCashReceipt);
    this.payment.cashReceipt.isIssueCashReceipt = isIssueCashReceipt;
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