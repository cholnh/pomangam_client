import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/order/item/order_item_request.dart';

part 'order_request.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderRequest {

  /// 주문 날짜
  DateTime orderDate;

  /// 주문 시간
  int idxOrderTime;

  /// 받는 장소
  int idxDeliveryDetailSite;

  /// PaymentInfo
  int idxPayment;

  int usingPoint;

  String usingCouponCode;

  Set<int> idxesUsingCoupons = Set();

  Set<int> idxesUsingPromotions = Set();

  String cashReceipt;

  List<OrderItemRequest> orderItems = List();

  OrderRequest({
    this.orderDate, this.idxOrderTime, this.idxDeliveryDetailSite,
    this.idxPayment, this.usingPoint, this.usingCouponCode, this.idxesUsingCoupons,
    this.idxesUsingPromotions, this.cashReceipt, this.orderItems
  });

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);
}