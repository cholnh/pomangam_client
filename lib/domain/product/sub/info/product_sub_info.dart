import 'package:json_annotation/json_annotation.dart';

part 'product_sub_info.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductSubInfo {

  String name;

  String description;

  String subDescription;

  ProductSubInfo({this.name, this.description, this.subDescription});

  factory ProductSubInfo.fromJson(Map<String, dynamic> json) => _$ProductSubInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSubInfoToJson(this);
}