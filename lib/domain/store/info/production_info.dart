import 'package:json_annotation/json_annotation.dart';

part 'production_info.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductionInfo {

  /// 최소 생산 가능 시간
  ///
  /// (단위: 분)
  int minimumTime;

  /// 평균 병렬 생산량
  ///
  /// (단위: 수량/1분)
  int parallelProduction;

  /// 최대 생상 가능 수량
  int maximumProduction;

  ProductionInfo({
      this.minimumTime, this.parallelProduction, this.maximumProduction
  });

  factory ProductionInfo.fromJson(Map<String, dynamic> json) => _$ProductionInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionInfoToJson(this);
}