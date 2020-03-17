import 'package:json_annotation/json_annotation.dart';

part 'store_quantity_orderable.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class StoreQuantityOrderable {

  /// 업체 인덱스
  int idx;

  /// 주문 가능 수량
  int quantityOrderable;

  StoreQuantityOrderable({this.idx, this.quantityOrderable});

  factory StoreQuantityOrderable.fromJson(Map<String, dynamic> json) => _$StoreQuantityOrderableFromJson(json);
  Map<String, dynamic> toJson() => _$StoreQuantityOrderableToJson(this);
  static List<StoreQuantityOrderable> fromJsonList(List<dynamic> jsonList) {
    List<StoreQuantityOrderable> entities = [];
    jsonList.forEach((map) => entities.add(StoreQuantityOrderable.fromJson(map)));
    return entities;
  }
}