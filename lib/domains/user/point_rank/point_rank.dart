import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

part 'point_rank.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class PointRank extends EntityAuditing {

  int level;
  String title;
  int nextLowerLimitOrderCount;
  int nextLowerLimitRecommendCount;
  int rewardCouponPrice;
  int percentSavePoint;
  int priceSavePoint;
  int userOrderCount;
  int userRecommendCount;

  PointRank({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.level, this.title, this.nextLowerLimitOrderCount,
    this.nextLowerLimitRecommendCount, this.rewardCouponPrice,
    this.percentSavePoint, this.priceSavePoint, this.userOrderCount,
    this.userRecommendCount
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  int savedPoint(int totalPrice) {
    return ((totalPrice * percentSavePoint / 100) + priceSavePoint).toInt();
  }

  factory PointRank.fromJson(Map<String, dynamic> json) => _$PointRankFromJson(json);
  Map<String, dynamic> toJson() => _$PointRankToJson(this);
}