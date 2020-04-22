class StringUtils {
  static final RegExp regExp = RegExp(r'([0-9]|\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
  static final RegExp regExp2 = RegExp('[ \\][`₩~!@#\$%^&*()_+-=,.?\":{}|<>]|[]');
  static final RegExp regExp3 = RegExp(r'\\');
  static final RegExp regExpKoreaPhoneNumber = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  static final RegExp regNum = RegExp(r'[^0-9]');
  static final RegExp regExpNickname = RegExp(r'^[가-힣A-Za-z0-9]{2,10}$');
  static final RegExp regExpCouponCode = RegExp(r'^[A-Za-z0-9]{8,12}$');
  static final RegExp regComma = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  static String removeEmojiAndSymbol(String content) {
    content = content.replaceAll(regExp, '');
    content = content.replaceAll(regExp2, '');
    return content.replaceAll(regExp3, '');
  }

  static bool hasEmojiAndSymbol(String content) {
    return content.contains(regExp) || content.contains(regExp2) || content.contains(regExp3);
  }

  static bool isValidKoreaPhoneNumber(String phoneNumber) {
    if(phoneNumber != null && phoneNumber.isNotEmpty) {
      return regExpKoreaPhoneNumber.hasMatch(phoneNumber);
    }
    return false;
  }

  static bool isValidCouponCode(String couponCode) {
    if(couponCode != null && couponCode.isNotEmpty) {
      couponCode = couponCode.trim().replaceAll('-', '');
      return regExpCouponCode.hasMatch(couponCode);
    }
    return false;
  }

  static String onlyNumber(String content) {
    return content.replaceAll(regNum, '');
  }

  static bool isValidNickname(String content) {
    if(content != null && content.isNotEmpty) {
      return regExpNickname.hasMatch(content);
    }
    return false;
  }

  static String comma(int number) {
    return number == null ? 0 : number.toString().replaceAllMapped(regComma, (Match match) => '${match[1]},');
  }
}

void main() {
  print(StringUtils.isValidNickname('정상적인텍스트'));
  print(StringUtils.isValidNickname('정상적인 텍스트'));
  print(StringUtils.isValidNickname('123'));
  print(StringUtils.isValidNickname('123asdfs23'));
  print(StringUtils.isValidNickname('123asdf123213123s23'));
  print(StringUtils.isValidNickname('ㄲㄱ'));
  print(StringUtils.isValidNickname('ㄲㄱ가까깧'));
  print(StringUtils.isValidNickname('가까깧꿿꿇쀍'));
  print(StringUtils.isValidNickname('까깧꿿꿇쀍 '));
  print(StringUtils.isValidNickname('까깧꿿꿇쀍!!@호'));

}