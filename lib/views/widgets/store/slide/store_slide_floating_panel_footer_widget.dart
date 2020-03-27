import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/views/pages/payment/payment_page_type.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:provider/provider.dart';

class StoreSlideFloatingPanelFooterWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PaymentModel paymentModel = Provider.of<PaymentModel>(context);
    PaymentType paymentType = paymentModel.payment?.paymentType;

    return Column(
      children: <Widget>[
        Divider(height: 40.0, thickness: 8.0, color: Colors.black.withOpacity(0.03)),
        GestureDetector(
          onTap: () => _navigateToPayment(context),
          child: Material(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 15.0),
              child: Consumer<CartModel>(
                builder: (_, model, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              convertPaymentTypeToIcon(paymentType),
                              Padding(padding: EdgeInsets.only(right: 4.0)),
                              Text('${convertPaymentTypeToText(paymentType)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0))
                            ],
                          ),
                          Text('변경', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: titleFontSize))
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 3.0)),
                      Text(
                        '포인트 3,000원 사용, 쿠폰 1,000원 사용',
                        style: TextStyle(fontSize: 12, color: subTextColor)
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToPayment(BuildContext context) {
    Navigator.pushNamed(context, '/payments', arguments: PaymentPageType.FROM_CART);
  }
}
