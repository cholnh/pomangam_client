import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/domains/cart/cart.dart';
import 'package:pomangam_client/domains/order/order_request.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/order/order_model.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/views/pages/payment/agreement/payment_agreement_page_type.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_body_widget.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_footer_widget.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_header_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client/_bases/key/shared_preference_key.dart' as s;

class StoreSlideFloatingPanelWidget extends StatelessWidget {

  final Function onSaveOrder;

  StoreSlideFloatingPanelWidget({this.onSaveOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]
      ),
      margin: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 53.0),
            child: Column(
              children: <Widget>[
                StoreSlideFloatingPanelHeaderWidget(),
                Flexible(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      StoreSlideFloatingPanelBodyWidget()
                    ],
                  ),
                ),
                StoreSlideFloatingPanelFooterWidget()
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer<OrderModel>(
              builder: (_, orderModel, __) {
                bool isSaving = orderModel.isSaving;
                return Consumer<CartModel>(
                  builder: (_, cartModel, __) {
                    PaymentModel paymentModel = Provider.of<PaymentModel>(context);
                    bool isPayable = paymentModel.isReadyPayment() && cartModel.isUpdatedOrderableStore && cartModel.isAllOrderable;

                    return GestureDetector(
                      child: Opacity(
                        opacity: !isSaving && isPayable ? 1.0 : 0.5,
                        child: Container(
                          color: primaryColor,
                          width: MediaQuery.of(context).size.width,
                          height: 53.0,
                          child: Center(
                            child: isSaving
                              ? CupertinoActivityIndicator()
                              : Text('${StringUtils.comma(cartModel.totalPrice())}원 결제하기', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)),
                          ),
                        ),
                      ),
                      onTap: !isSaving && isPayable
                          ? () => _saveOrder(context)
                          : () {},
                    );
                  }
                );
              }
            )
          )
        ],
      ),
    );
  }

  void _saveOrder(BuildContext context) async {
    OrderModel orderModel = Provider.of<OrderModel>(context, listen: false);
    if(orderModel.isSaving) return;

    PaymentModel paymentModel = Provider.of<PaymentModel>(context, listen: false);
    bool isPaymentAgree = paymentModel.payment?.isPaymentAgree == null ? false : paymentModel.payment?.isPaymentAgree;
    if(isPaymentAgree) {

      SharedPreferences prefs = await SharedPreferences.getInstance();


      CartModel cartModel = Provider.of<CartModel>(context, listen: false);
      Cart cart = cartModel.cart;

      OrderRequest orderRequest = OrderRequest(
          orderDate: cart.orderDate,
          idxFcmToken: prefs.get(s.idxFcmToken),
          idxOrderTime: cart.orderTime.idx,
          idxDeliveryDetailSite: cart.detail.idx,
          paymentType: paymentModel.payment.paymentType,
          usingPoint: cartModel.usingPoint,
          usingCouponCode: cartModel.usingCouponCode?.code,
          idxesUsingCoupons: cartModel.usingCoupons.map((coupon) => coupon.idx).toSet(),
          idxesUsingPromotions: cartModel.usingPromotions.map((promotion) => promotion.idx).toSet(),
          cashReceipt: paymentModel.payment.cashReceipt?.cashReceiptNumber,
          cashReceiptType: paymentModel.payment.cashReceipt?.cashReceiptType,
          orderItems: cart.orderItems()
      );
      cartModel.clear();
      await orderModel.saveOrder(orderRequest: orderRequest);

      onSaveOrder();
    } else {
      Navigator.pushNamed(context, '/payments/agreements', arguments: PaymentAgreementPageType.FROM_CART);
    }
  }
}
