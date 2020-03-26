import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

part 'coupon.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Coupon extends EntityAuditing {

  int discountCost;
  String title;
  String code;
  int idxUser;
  DateTime beginDate;
  DateTime endDate;

  Coupon({
    this.discountCost, this.title, this.code,
    this.idxUser, this.beginDate, this.endDate
  });

  bool isValid() {
    DateTime now = DateTime.now();
    return beginDate.isBefore(now) && endDate.isAfter(now);
  }

  Map<String, dynamic> toJson() => _$CouponToJson(this);
  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}