import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

enum PaymentType { CREDIT_CARD, PHONE, V_BANK }

PaymentType convertTextToPaymentType(String type) {
  if(type == null) return null;
  return PaymentType.values.singleWhere((value) => value.toString().toUpperCase() == type.toUpperCase());
}

String convertPaymentTypeToText(PaymentType type) {
  if(type != null) {
    switch(type) {
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

Widget convertPaymentTypeToIcon(PaymentType type) {
  if(type != null) {
    switch(type) {
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