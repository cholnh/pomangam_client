import 'package:json_annotation/json_annotation.dart';

part 'product_info.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductInfo {

  /// 제품명
  ///
  /// 글자수: utf8 기준 / 영문 20자 / 한글 20자
  String name;

  /// 제품 설명
  ///
  /// TEXT: 65535 Byte (64KB) / utf8 기준(3바이트 문자)으로 21844 글자 저장가능
  String description;

  /// 제품 부가 설명
  ///
  /// 글자수: utf8 기준 / 영문 255자 / 한글 255자
  String subDescription;

  ProductInfo({this.name, this.description, this.subDescription});

  factory ProductInfo.fromJson(Map<String, dynamic> json) => _$ProductInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}