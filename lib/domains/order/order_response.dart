
import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';
import 'package:pomangam_client/domains/coupon/coupon.dart';
import 'package:pomangam_client/domains/order/item/order_item_response.dart';
import 'package:pomangam_client/domains/order/order_type.dart';
import 'package:pomangam_client/domains/order/orderer/orderer_type.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';
import 'package:pomangam_client/domains/promotion/promotion.dart';

part 'order_response.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderResponse extends EntityAuditing {

  // 주문 기본 정보
  OrderType orderType;
  int boxNumber;
  PaymentType paymentType;
  OrdererType ordererType;

  // 결제 정보
  int usingPoint;
  List<Coupon> usingCoupons = List();
  List<Promotion> usingPromotions = List();
  int savedPoint;
  String cashReceipt;
  int totalCost;
  int discountCost;
  int paymentCost;

  // 받는 장소
  int idxDeliverySite;
  int idxDeliveryDetailSite;
  String nameDeliverySite;
  String nameDeliveryDetailSite;

  // 받는 날짜
  DateTime orderDate;

  // 받는 시간
  int idxOrderTime;
  String arrivalTime;
  String additionalTime;

  List<OrderItemResponse> orderItems = List();

  OrderResponse({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.orderType, this.boxNumber, this.paymentType,
    this.ordererType, this.usingPoint, this.usingCoupons,
    this.usingPromotions, this.savedPoint, this.cashReceipt, this.totalCost,
    this.discountCost, this.paymentCost, this.idxDeliverySite,
    this.idxDeliveryDetailSite, this.nameDeliverySite,
    this.nameDeliveryDetailSite, this.orderDate, this.idxOrderTime,
    this.arrivalTime, this.additionalTime, this.orderItems
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);

  @override
  String toString() {
    return '[OrderResponse]\n\norderType: $orderType\nboxNumber: $boxNumber\npaymentType: $paymentType\nordererType: $ordererType\nusingPoint: $usingPoint\nusingCoupons: $usingCoupons\nusingPromotions: $usingPromotions\nsavedPoint: $savedPoint\ncashReceipt: $cashReceipt\ntotalCost: $totalCost\ndiscountCost: $discountCost\npaymentCost: $paymentCost\nidxDeliverySite: $idxDeliverySite\nidxDeliveryDetailSite: $idxDeliveryDetailSite\nnameDeliverySite: $nameDeliverySite\nnameDeliveryDetailSite: $nameDeliveryDetailSite\norderDate: $orderDate\nidxOrderTime: $idxOrderTime\narrivalTime: $arrivalTime\nadditionalTime: $additionalTime\n\n$orderItems';
  }
}