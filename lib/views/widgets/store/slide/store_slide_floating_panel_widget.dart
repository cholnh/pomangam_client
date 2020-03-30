import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/views/pages/payment/agreement/payment_agreement_page_type.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_body_widget.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_footer_widget.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_header_widget.dart';
import 'package:provider/provider.dart';

class StoreSlideFloatingPanelWidget extends StatelessWidget {

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
            child: Consumer<CartModel>(
              builder: (_, model, __) {
                PaymentModel paymentModel = Provider.of<PaymentModel>(context);
                bool isPayable = paymentModel.isReadyPayment() && model.isUpdatedOrderableStore && model.isAllOrderable;

                return GestureDetector(
                  child: Opacity(
                    opacity: isPayable ? 1.0 : 0.5,
                    child: Container(
                      color: primaryColor,
                      width: MediaQuery.of(context).size.width,
                      height: 53.0,
                      child: Center(
                        child: Text('${StringUtils.comma(model.totalPrice())}원 결제하기', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)),
                      ),
                    ),
                  ),
                  onTap: isPayable
                    ? () => _saveOrder(context)
                    : () {},
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _saveOrder(BuildContext context) {
    PaymentModel paymentModel = Provider.of<PaymentModel>(context, listen: false);
    bool isPaymentAgree = paymentModel.payment?.isPaymentAgree == null ? false : paymentModel.payment?.isPaymentAgree;
    if(isPaymentAgree) {
      print('[결제하기 누름]');
      CartModel cartModel = Provider.of<CartModel>(context, listen: false);
      cartModel.cart.items.forEach((item) {
        print('${item.product.productInfo.name} ${item.quantity}개');
        item.subs.forEach((sub) {
          print('  - ${sub.productSubInfo.name} ${item.quantity}개');
        });
        print('요구사항: ${item.requirement}');
        print('총액: ${item.totalPrice()}');
        print('------------------------------');
      });
    } else {
      Navigator.pushNamed(context, '/payments/agreements', arguments: PaymentAgreementPageType.FROM_CART);
    }
  }
}
