
import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable(nullable: false)
class Store {

  int idx;

  String title;

  String foodCategory;

  String description;

  String subDescription;

  double avgStar;

  int cntLike;

  int cntComment;

  List<String> productCategories;

  String brandImagePath;

  Store(this.idx, this.title, this.foodCategory, this.description, this.avgStar,
      this.cntLike, this.cntComment, this.productCategories,
      this.brandImagePath);

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}