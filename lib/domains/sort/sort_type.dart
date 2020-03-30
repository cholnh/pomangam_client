enum SortType {
  SORT_BY_RECOMMEND_DESC,
  SORT_BY_ORDER_DESC,
  SORT_BY_STAR_DESC,
  SORT_BY_REVIEW_DESC
}

SortType convertTextToSortType(String type) {
  if(type == null) return null;
  return SortType.values.singleWhere((value) => value.toString().toUpperCase() == type.toUpperCase());
}

String convertSortTypeToText(SortType type) {
  if(type != null) {
    switch(type) {
      case SortType.SORT_BY_RECOMMEND_DESC:
        return '추천순';
      case SortType.SORT_BY_ORDER_DESC:
        return '주문많은순';
      case SortType.SORT_BY_STAR_DESC:
        return '별점높은순';
      case SortType.SORT_BY_REVIEW_DESC:
        return '리뷰많은순';
    }
  }
  return '';
}