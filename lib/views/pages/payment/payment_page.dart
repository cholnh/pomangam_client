import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client/domains/payment/payment_page_type.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';
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
    PaymentPageType paymentPageType = ModalRoute.of(context).settings?.arguments ?? PaymentPageType.FROM_SETTING;
    CartModel cartModel = Provider.of<CartModel>(context);

    return SafeArea(
      child: Scaffold(
        appBar: PaymentAppBar(context, title: '결제'),
        body: Consumer<PaymentModel>(
          builder: (_, paymentModel, __) {
            PaymentType paymentType = paymentModel.payment?.paymentType;
            CashReceiptType cashReceiptType = paymentModel.payment?.cashReceipt?.cashReceiptType;
            String cashReceiptNumber = paymentModel.payment?.cashReceipt?.cashReceiptNumber ?? '';
            bool isIssueCashReceipt = paymentModel.payment?.cashReceipt?.isIssueCashReceipt == null ? false : paymentModel.payment.cashReceipt.isIssueCashReceipt;
            bool isPaymentAgree = paymentModel.payment?.isPaymentAgree == null ? false : paymentModel.payment.isPaymentAgree;
            return Column(
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: paymentPageType == PaymentPageType.FROM_CART
                          ? Center(
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
                          )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                          ),
                      ),
                      PaymentItemWidget(
                        title: '결제수단',
                        subTitle: convertPaymentTypeToText(paymentType),
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
                        subTitle: isIssueCashReceipt ? '${convertCashReceiptTypeToShortText(cashReceiptType)} $cashReceiptNumber' : '미발급',
                        onSelected: () => Navigator.pushNamed(context, '/payments/cashreceipts'),
                      ),
                      PaymentItemWidget(
                        title: '결제에 관한 동의',
                        subTitle: !isPaymentAgree || paymentModel.payment?.paymentAgreeDate == null ? '결제를 위해 동의가 필요합니다.' : '${_agreementDate(paymentModel.payment.paymentAgreeDate)} 동의 완료',
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            isPaymentAgree ? '동의' : '동의 안 함',
                            style: TextStyle(color: primaryColor, fontSize: 14.0, fontWeight: FontWeight.bold)),
                        ),
                        onSelected: () => Navigator.pushNamed(context, '/payments/agreements'),
                      )
                    ],
                  ),
                ),
                paymentPageType == PaymentPageType.FROM_CART
                ? PaymentBottomBar(
                    centerText: '완료',
                    onSelected: () => _onBottomSelected(context),
                )
                : Container()
              ],
            );
          },
        )
      ),
    );
  }

  void _onBottomSelected(BuildContext context) {
    Navigator.pop(context, false);

    // toast 메시지
    Fluttertoast.showToast(
        msg: "적용완료",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: titleFontSize
    );
  }

  String _agreementDate(DateTime dt) {
    return DateFormat('yyyy년 MM월 dd일').format(dt);
  }

  void _init({bool isBuild = false}) {
  }
}