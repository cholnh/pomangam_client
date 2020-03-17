import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_schedule.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class StoreSchedule {

  /// 영업 시작 시간
  String openTime;

  /// 영업 종료 시간
  String closeTime;

  /// 오프닝(휴일 포함) 여부 (Y/N)
  ///
  /// default: true(Y)
  /// 대문자 필수
  /// true: 영업 개시
  /// false: 영업 일시 정지
  bool isOpening;

  /// 정지 사유
  ///
  /// 영업 일시 정지(isOpening-false) 상태일 때 View 단에 표현됨.
  /// 글자수: utf8 기준 / 영문 255자 / 한글 255자
  String pauseDescription;

  StoreSchedule({
      this.openTime, this.closeTime, this.isOpening, this.pauseDescription
  });

  factory StoreSchedule.fromJson(Map<String, dynamic> json) => _$StoreScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$StoreScheduleToJson(this);

  DateTime getOpenDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd hh:mm:ss').parse('${now.year}-${now.month}-${now.day} ${this.openTime}');
  }

  DateTime getCloseDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd hh:mm:ss').parse('${now.year}-${now.month}-${now.day} ${this.closeTime}');
  }
  
  bool isOpenTime() {
    return isOpening &&
        DateTime.now().isAfter(getOpenDateTime()) &&
        DateTime.now().isBefore(getCloseDateTime());
  }
}