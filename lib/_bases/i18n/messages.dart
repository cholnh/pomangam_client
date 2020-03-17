import 'package:intl/intl.dart';

class Messages {

  /* !! method name 과 'name' property 는 일치 해야 함. !! */


  // Common
  static String get appName => Intl.message('Todo List',
      name: 'appName'
  );
  static String get companyName => Intl.message('© LOCALLECT:ON',
      name: 'companyName'
  );
  static String get tabHomeTitle => Intl.message('홈',
      name: 'tabHomeTitle'
  );
  static String get tabRecommendTitle => Intl.message('뭐먹지',
      name: 'tabRecommendTitle'
  );
  static String get tabOrderInfoTitle => Intl.message('주문내역',
      name: 'tabOrderInfoTitle'
  );
  static String get tabMoreTitle => Intl.message('더보기',
      name: 'tabMoreTitle'
  );


  // Delivery
  static String get sortPickerTitle => Intl.message('매장 정렬',
      name: 'sortPickerTitle'
  );
  static String get timePickerTitle => Intl.message('배달 도착 시간',
      name: 'timePickerTitle'
  );


  // Not found
  static String get notFoundMsg => Intl.message('UNKNOWN PAGE',
      name: 'notFoundMsg'
  );
  static String get notFoundBackBtn => Intl.message('back',
      name: 'notFoundBackBtn'
  );
  static String get notFoundHomeBtn => Intl.message('home',
      name: 'notFoundHomeBtn'
  );
  static String get errorMsg => Intl.message('Error',
      name: 'errorMsg'
  );

}