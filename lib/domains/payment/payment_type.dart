enum PaymentType { CREDIT_CARD, PHONE, V_BANK }

PaymentType convertPaymentType(String type) {
  if(type == null) return null;
  return PaymentType.values.singleWhere((value) => value.toString().toUpperCase() == type.toUpperCase());
}