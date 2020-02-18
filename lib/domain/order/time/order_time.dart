
import 'package:json_annotation/json_annotation.dart';

part 'order_time.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderTime {

  int idx;

  OrderTime({this.idx});

  factory OrderTime.fromJson(Map<String, dynamic> json) => _$OrderTimeFromJson(json);
  Map<String, dynamic> toJson() => _$OrderTimeToJson(this);
  static List<OrderTime> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<OrderTime> entities = [];
    jsonList.forEach((map) => entities.add(OrderTime.fromJson(map)));
    return entities;
  }
}