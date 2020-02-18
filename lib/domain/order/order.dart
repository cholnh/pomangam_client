
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Order {

  int idx;

  Order({this.idx});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
  static List<Order> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<Order> entities = [];
    jsonList.forEach((map) => entities.add(Order.fromJson(map)));
    return entities;
  }
}