import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/order/item/sub/order_item_sub_request.dart';

part 'order_item_request.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderItemRequest {

  int idxStore;
  int idxProduct;
  int quantity;
  String requirement;
  List<OrderItemSubRequest> orderItemSubs = List();

  OrderItemRequest({
    this.idxStore, this.idxProduct, this.quantity,
    this.requirement, this.orderItemSubs
  });

  Map<String, dynamic> toJson() => _$OrderItemRequestToJson(this);
  factory OrderItemRequest.fromJson(Map<String, dynamic> json) => _$OrderItemRequestFromJson(json);
}