enum CashReceiptType { PERSONAL, BUSINESS }

CashReceiptType convertCashReceiptType(String type) {
  if(type == null) return null;
  return CashReceiptType.values.singleWhere((value) => value.toString().toUpperCase() == type.toUpperCase());
}