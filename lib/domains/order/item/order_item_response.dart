import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';
import 'package:pomangam_client/domains/order/item/sub/order_item_sub_response.dart';

part 'order_item_response.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderItemResponse extends EntityAuditing {

  String nameStore;
  String nameProduct;
  int saleCost;
  int quantity;
  String requirement;
  List<OrderItemSubResponse> orderItemSubs = List();

  OrderItemResponse({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.nameStore, this.nameProduct, this.saleCost,
    this.quantity, this.requirement, this.orderItemSubs
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  Map<String, dynamic> toJson() => _$OrderItemResponseToJson(this);
  factory OrderItemResponse.fromJson(Map<String, dynamic> json) => _$OrderItemResponseFromJson(json);
}