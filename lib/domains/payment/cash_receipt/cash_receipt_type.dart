enum CashReceiptType { PERSONAL_PHONE_NUMBER, PERSONAL_CARD_NUMBER, BUSINESS_REGISTRATION_NUMBER, BUSINESS_CARD_NUMBER }

CashReceiptType convertTextToCashReceiptType(String type) {
  if(type == null) return null;
  return CashReceiptType.values.singleWhere((value) => value.toString().toUpperCase() == type.toUpperCase());
}

String convertCashReceiptTypeToText(CashReceiptType type) {
  if(type != null) {
    switch(type) {
      case CashReceiptType.PERSONAL_PHONE_NUMBER:
        return '개인소득공제 (휴대폰번호)';
      case CashReceiptType.PERSONAL_CARD_NUMBER:
        return '개인소득공제 (현금영수증카드)';
      case CashReceiptType.BUSINESS_REGISTRATION_NUMBER:
        return '사업자증빙 (사업자등록번호)';
      case CashReceiptType.BUSINESS_CARD_NUMBER:
        return '사업자증빙 (현금영수증카드)';
    }
  }
  return '설정 안 함';
}

String convertCashReceiptTypeToShortText(CashReceiptType type) {
  if(type != null) {
    switch(type) {
      case CashReceiptType.PERSONAL_PHONE_NUMBER:
        return '개인소득공제';
      case CashReceiptType.PERSONAL_CARD_NUMBER:
        return '개인소득공제';
      case CashReceiptType.BUSINESS_REGISTRATION_NUMBER:
        return '사업자증빙';
      case CashReceiptType.BUSINESS_CARD_NUMBER:
        return '사업자증빙';
    }
  }
  return '';
}