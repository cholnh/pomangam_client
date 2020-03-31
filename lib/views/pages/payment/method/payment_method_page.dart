import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/payment/payment_type.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:pomangam_client/views/widgets/payment/method/payment_method_add_widget.dart';
import 'package:pomangam_client/views/widgets/payment/method/payment_method_common_type_widget.dart';
import 'package:pomangam_client/views/widgets/payment/method/payment_method_user_type_widget.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:pomangam_client/views/widgets/payment/payment_bottom_bar.dart';
import 'package:pomangam_client/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {

  PaymentType viewPaymentType;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    PaymentModel paymentModel = Provider.of<PaymentModel>(context, listen: false);
    viewPaymentType = paymentModel.payment?.paymentType ?? PaymentType.COMMON_CREDIT_CARD;
  }

  @override
  Widget build(BuildContext context) {
    SignInModel signInModel = Provider.of<SignInModel>(context);
    bool isSignIn = signInModel.isSignIn();

    return Scaffold(
      appBar: PaymentAppBar(
        context,
        title: '결제수단',
        leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                      child: Text('내 결제', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    isSignIn ? PaymentMethodUserTypeWidget(
                      isFirst: true,
                      bankName: '우리카드',
                      bankNumberPreview: '3355**79**55*',
                      isSelected: viewPaymentType == PaymentType.PERIODIC_CREDIT_CARD,
                      paymentType: PaymentType.PERIODIC_CREDIT_CARD,
                      onSelected: () => _onTypeSelected(PaymentType.PERIODIC_CREDIT_CARD),
                    ) : Container(),
                    isSignIn ? PaymentMethodUserTypeWidget(
                      bankName: '카카오뱅크',
                      bankNumberPreview: '565**45****1',
                      isSelected: viewPaymentType == PaymentType.PERIODIC_FIRM_BANK,
                      paymentType: PaymentType.PERIODIC_FIRM_BANK,
                      onSelected: () => _onTypeSelected(PaymentType.PERIODIC_FIRM_BANK),
                    ) : Container(),
                    Padding(padding: const EdgeInsets.only(bottom: 10.0)),
                    PaymentMethodAddWidget(
                      onSelected: _onAddSelected,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
                      child: Text('일반 결제', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    PaymentMethodCommonTypeWidget(
                      isFirst: true,
                      paymentType: PaymentType.COMMON_CREDIT_CARD,
                      isSelected: viewPaymentType == PaymentType.COMMON_CREDIT_CARD,
                      onSelected: () => _onTypeSelected(PaymentType.COMMON_CREDIT_CARD),
                    ),
                    PaymentMethodCommonTypeWidget(
                      paymentType: PaymentType.COMMON_V_BANK,
                      isSelected: viewPaymentType == PaymentType.COMMON_V_BANK,
                      onSelected: () => _onTypeSelected(PaymentType.COMMON_V_BANK),
                    ),
                    PaymentMethodCommonTypeWidget(
                      paymentType: PaymentType.COMMON_KAKAOPAY,
                      isSelected: viewPaymentType == PaymentType.COMMON_KAKAOPAY,
                      onSelected: () => _onTypeSelected(PaymentType.COMMON_KAKAOPAY),
                    ),
                    PaymentMethodCommonTypeWidget(
                      paymentType: PaymentType.COMMON_PHONE,
                      isSelected: viewPaymentType == PaymentType.COMMON_PHONE,
                      onSelected: () => _onTypeSelected(PaymentType.COMMON_PHONE),
                    ),
                    PaymentMethodCommonTypeWidget(
                      paymentType: PaymentType.COMMON_REMOTE_PAY,
                      isSelected: viewPaymentType == PaymentType.COMMON_REMOTE_PAY,
                      onSelected: () => _onTypeSelected(PaymentType.COMMON_REMOTE_PAY),
                    )
                  ],
                ),
              ),
            ),
            PaymentBottomBar(
              centerText: '저장',
              isActive: true,
              onSelected: () => _onBottomSelected(),
              isVisible: isChanged,
            )
          ],
        ),
      ),
    );
  }

  void _onTypeSelected(PaymentType type) {
    setState(() {
      this.isChanged = true;
      this.viewPaymentType = type;
    });
  }

  void _onBottomSelected() {
    Provider.of<PaymentModel>(context, listen: false)
    ..savePaymentType(this.viewPaymentType);

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

  void _onAddSelected() {
    bool isSignIn = Provider.of<SignInModel>(context, listen: false).isSignIn();
    if(isSignIn) {
      Navigator.pushNamed(context, '/payments/methods/add');
    } else {
      showSignModal(context: context, returnUrl: '/payments/methods');
    }
  }
}