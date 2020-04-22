import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

part 'order_item_sub_response.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderItemSubResponse extends EntityAuditing {

  String nameProductSub;
  int saleCost;
  int quantity;

  OrderItemSubResponse({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.nameProductSub, this.saleCost, this.quantity
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  Map<String, dynamic> toJson() => _$OrderItemSubResponseToJson(this);
  factory OrderItemSubResponse.fromJson(Map<String, dynamic> json) => _$OrderItemSubResponseFromJson(json);

  @override
  String toString() {
    return '[OrderItemSubResponse]\n\nnameProductSub: $nameProductSub\nsaleCost: $saleCost\nquantity: $quantity';
  }
}