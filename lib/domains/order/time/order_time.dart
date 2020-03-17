
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

part 'order_time.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderTime extends EntityAuditing {

  String arrivalTime;
  String pickUpTime;
  String orderEndTime;

  OrderTime({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.arrivalTime, this.pickUpTime, this.orderEndTime
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory OrderTime.fromJson(Map<String, dynamic> json) => _$OrderTimeFromJson(json);
  Map<String, dynamic> toJson() => _$OrderTimeToJson(this);
  static List<OrderTime> fromJsonList(List<dynamic> jsonList) {
    List<OrderTime> entities = [];
    jsonList.forEach((map) => entities.add(OrderTime.fromJson(map)));
    return entities;
  }

  DateTime getArrivalDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse('${now.year}-${now.month}-${now.day} ${this.arrivalTime}');
  }

  DateTime getPickUpDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse('${now.year}-${now.month}-${now.day} ${this.pickUpTime}');
  }

  DateTime getOrderEndDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse('${now.year}-${now.month}-${now.day} ${this.orderEndTime}');
  }

  @override
  String toString() {
    return 'OrderTime{arrivalTime: $arrivalTime, pickUpTime: $pickUpTime, orderEndTime: $orderEndTime}';
  }
}