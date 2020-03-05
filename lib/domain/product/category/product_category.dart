import 'package:json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductCategory {

  int idx;

  String categoryTitle;

  ProductCategory({this.idx, this.categoryTitle});

  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}