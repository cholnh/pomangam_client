enum PointType {

  /// 프로모션에 의한 포인트 발급
  ISSUED_BY_PROMOTION,

  /// 구매활동에 의한 포인트 발급
  ISSUED_BY_BUY,

  /// 주문취소에 의한 포인트 환급
  ROLLBACK_BY_PAYMENT_CANCEL,

  /// 구매활동에 의한 포인트 사용
  USED_BY_BUY,

  /// 관리자에 의한 포인트 수정 (증가)
  UPDATED_PLUS_BY_ADMIN,

  /// 관리자에 의한 포인트 수정 (차감)
  UPDATED_MINUS_BY_ADMIN
}