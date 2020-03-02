import 'package:json_annotation/json_annotation.dart';

part 'store_info.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class StoreInfo {

  /// 업체명
  ///
  /// 글자수: utf8 기준 / 영문 20자 / 한글 20자
  String name;

  /// 업체 설명
  ///
  /// TEXT: 65535 Byte (64KB) / utf8 기준(3바이트 문자)으로 21844 글자 저장가능
  String description;

  /// 업체 부가 설명
  ///
  /// 글자수: utf8 기준 / 영문 255자 / 한글 255자
  String subDescription;

  /// 업주 이름
  ///
  /// 글자수: utf8 기준 / 영문 20자 / 한글 20자
  String ownerName;

  /// 업체 사업장 명
  ///
  /// 글자수: utf8 기준 / 영문 50자 / 한글 50자
  String companyName;

  /// 업체 사업장 위치
  ///
  /// 글자수: utf8 기준 / 영문 255자 / 한글 255자
  String companyLocation;

  /// 업체 사업장 전화번호
  ///
  /// 글자수: utf8 기준 / 영문 20자 / 한글 20자
  String companyPhoneNumber;

  StoreInfo({
      this.name, this.description, this.subDescription, this.ownerName,
      this.companyName, this.companyLocation, this.companyPhoneNumber
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) => _$StoreInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StoreInfoToJson(this);
}