import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

part 'coupon.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Coupon extends EntityAuditing {

  bool isUsed;
  int discountCost;
  String title;
  String code;
  int idxUser;
  DateTime beginDate;
  DateTime endDate;

  Coupon({
    this.isUsed, this.discountCost, this.title, this.code,
    this.idxUser, this.beginDate, this.endDate
  });

  bool isValid() {
    DateTime now = DateTime.now();
    return !isUsed && beginDate.isBefore(now) && (endDate == null || endDate.isAfter(now));
  }

  Map<String, dynamic> toJson() => _$CouponToJson(this);
  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  static List<Coupon> fromJsonList(List<dynamic> jsonList) {
    List<Coupon> entities = [];
    jsonList.forEach((map) => entities.add(Coupon.fromJson(map)));
    return entities;
  }
}