import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:pomangam_client/views/widgets/payment/payment_bottom_bar.dart';
import 'package:pomangam_client/views/widgets/payment/payment_item_widget.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    CartModel cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: PaymentAppBar(context, title: '결제'),
      bottomNavigationBar: PaymentBottomBar(),
      body: Consumer<PaymentModel>(
        builder: (_, paymentModel, __) {
          bool isPaymentAgree = paymentModel.payment?.isPaymentAgree == null ? false : paymentModel.payment?.isPaymentAgree;
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('결제금액', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
                        Text(' ${StringUtils.comma(cartModel.cart.totalPrice())}원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: primaryColor)),
                      ],
                    ),
                  ),
                ),
              ),
              PaymentItemWidget(
                title: '결제수단',
                subTitle: paymentModel.textPaymentType(),
                onSelected: () => Navigator.pushNamed(context, '/payments/methods'),
              ),
              PaymentItemWidget(
                title: '포인트',
                subTitle: '3,400원 사용가능',
                onSelected: () => Navigator.pushNamed(context, '/payments/points'),
                isActive: false,
              ),
              PaymentItemWidget(
                title: '할인쿠폰',
                subTitle: '쿠폰코드를 입력 또는 선택해 주세요',
                onSelected: () => Navigator.pushNamed(context, '/payments/coupons'),
              ),
              PaymentItemWidget(
                title: '현금영수증',
                subTitle: '${paymentModel.textCashReceiptType()} ${paymentModel.payment?.cashReceipt?.cashReceiptNumber ?? ''}',
                onSelected: () => Navigator.pushNamed(context, '/payments/cashreceipts'),
              ),
              PaymentItemWidget(
                title: '결제에 관한 동의',
                subTitle: !isPaymentAgree || paymentModel.payment?.paymentAgreeDate == null ? '결제를 위해 동의가 필요합니다.' : '${_agreementDate(paymentModel.payment.paymentAgreeDate)}',
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    isPaymentAgree ? '동의' : '동의 안 함',
                    style: TextStyle(color: primaryColor, fontSize: 14.0, fontWeight: FontWeight.bold)),
                ),
                onSelected: () => Navigator.pushNamed(context, '/payments/agreements'),
              )
            ],
          );
        },
      )
    );
  }


  String _agreementDate(DateTime dt) {
    return DateFormat('yyyy년 MM월 dd일').format(dt);
  }

  void _init({bool isBuild = false}) async {

  }
}