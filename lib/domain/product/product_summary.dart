import 'package:json_annotation/json_annotation.dart';

part 'product_summary.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductSummary {

  int idx;

  int salePrice;

  String name;

  String productImageMainPath;

  ProductSummary({this.idx, this.salePrice, this.name, this.productImageMainPath});

  factory ProductSummary.fromJson(Map<String, dynamic> json) => _$ProductSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSummaryToJson(this);
  static List<ProductSummary> fromJsonList(List<dynamic> jsonList) {
    List<ProductSummary> entities = [];
    jsonList.forEach((map) => entities.add(ProductSummary.fromJson(map)));
    return entities;
  }
}