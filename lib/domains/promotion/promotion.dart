import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

part 'promotion.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Promotion extends EntityAuditing {

  int discountCost;
  String title;
  String contents;
  DateTime beginDate;
  DateTime endDate;

  Promotion({
    this.discountCost, this.title, this.contents,
    this.beginDate, this.endDate
  });

  bool isValid() {
    DateTime now = DateTime.now();
    return beginDate.isBefore(now) && endDate.isAfter(now);
  }

  Map<String, dynamic> toJson() => _$PromotionToJson(this);
  factory Promotion.fromJson(Map<String, dynamic> json) => _$PromotionFromJson(json);
}