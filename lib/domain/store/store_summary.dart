import 'package:json_annotation/json_annotation.dart';

part 'store_summary.g.dart';

@JsonSerializable(nullable: false)
class StoreSummary {

  int idx;

  String title;

  String description;

  String subDescription;

  double avgStar;

  int cntLike;

  int cntComment;

  List<String> storeImagePaths;

  String brandImagePath;

  int promotionType;

  int promotionValue; // promotionType: 0 -> 할인안함 / 1 -> 할인가(단위: 원) / 2 -> 할인률(단위: %)

  int couponType;

  int couponValue;  // couponType: 0 -> 쿠폰제공안함 / 1-> 쿠폰제공가격(단위: 원)

  StoreSummary(this.idx, this.title, this.description, this.subDescription,
      this.avgStar, this.cntLike, this.cntComment, this.storeImagePaths,
      this.brandImagePath, this.promotionType, this.promotionValue,
      this.couponType,
      this.couponValue);

  factory StoreSummary.fromJson(Map<String, dynamic> json) => _$StoreSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$StoreSummaryToJson(this);
  static List<StoreSummary> fromJsonList(List<dynamic> jsonList) {
    List<StoreSummary> entities = [];
    jsonList.forEach((map) => entities.add(StoreSummary.fromJson(map)));
    return entities;
  }
}