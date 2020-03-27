import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/user/point_log/point_type.dart';

part 'point_log.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class PointLog {

  int idx;
  int idxOrder;
  int idxUser;
  PointType pointType;
  int point;
  int postPoint;
  DateTime registerDate;
  DateTime expiredDate;

  PointLog({
    this.idx, this.idxOrder, this.idxUser, this.pointType,
    this.point, this.postPoint, this.registerDate, this.expiredDate
  });

  factory PointLog.fromJson(Map<String, dynamic> json) => _$PointLogFromJson(json);
  Map<String, dynamic> toJson() => _$PointLogToJson(this);
  static List<PointLog> fromJsonList(List<dynamic> jsonList) {
    List<PointLog> entities = [];
    jsonList.forEach((map) => entities.add(PointLog.fromJson(map)));
    return entities;
  }
}