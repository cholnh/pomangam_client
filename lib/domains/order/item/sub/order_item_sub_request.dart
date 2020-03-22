import 'package:json_annotation/json_annotation.dart';

part 'order_item_sub_request.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderItemSubRequest {

  int idxProductSub;
  int quantity;

  OrderItemSubRequest({
    this.idxProductSub, this.quantity
  });

  Map<String, dynamic> toJson() => _$OrderItemSubRequestToJson(this);
  factory OrderItemSubRequest.fromJson(Map<String, dynamic> json) => _$OrderItemSubRequestFromJson(json);
}