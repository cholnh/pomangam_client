import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/views/widgets/payment/cash_receipt/payment_cash_receipt_number_widget.dart';
import 'package:pomangam_client/views/widgets/payment/cash_receipt/payment_cash_receipt_switch_widget.dart';
import 'package:pomangam_client/views/widgets/payment/cash_receipt/payment_cash_receipt_type_modal.dart';
import 'package:pomangam_client/views/widgets/payment/cash_receipt/payment_cash_receipt_type_widget.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:pomangam_client/views/widgets/payment/payment_bottom_bar.dart';
import 'package:provider/provider.dart';

class PaymentCashReceiptPage extends StatefulWidget {

  @override
  _PaymentCashReceiptPageState createState() => _PaymentCashReceiptPageState();
}

class _PaymentCashReceiptPageState extends State<PaymentCashReceiptPage> {

  TextEditingController _textEditingController;

  bool isChanged = false;
  bool isNumberMode = false;
  bool isNumberEmpty = false;
  bool viewIsIssueCashReceipt;
  CashReceiptType viewCashReceiptType;
  String viewCashReceiptNumber;

  @override
  void initState() {
    super.initState();
    PaymentModel paymentModel = Provider.of<PaymentModel>(context, listen: false);
    viewIsIssueCashReceipt = paymentModel.payment?.cashReceipt?.isIssueCashReceipt == null ? false : paymentModel.payment.cashReceipt.isIssueCashReceipt;
    viewCashReceiptType = paymentModel.payment?.cashReceipt?.cashReceiptType ?? CashReceiptType.PERSONAL_PHONE_NUMBER;
    viewCashReceiptNumber = paymentModel.payment?.cashReceipt?.cashReceiptNumber ?? '설정 안 함';

    _textEditingController = TextEditingController();
    _textEditingController.text = paymentModel.payment?.cashReceipt?.cashReceiptNumber ?? '';
    isNumberEmpty = _textEditingController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaymentAppBar(
        context,
        title: '현금영수증',
        leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    PaymentCashReceiptSwitchWidget(
                      isIssueCashReceipt: viewIsIssueCashReceipt,
                      onSelected: _onSwitchSelected,
                    ),
                    PaymentCashReceiptTypeWidget(
                      isIssueCashReceipt: viewIsIssueCashReceipt,
                      onSelected: _showModal,
                      cashReceiptType: viewCashReceiptType,
                    ),
                    PaymentCashReceiptNumberWidget(
                      textEditingController: _textEditingController,
                      cashReceiptNumber: viewCashReceiptNumber,
                      isIssueCashReceipt: viewIsIssueCashReceipt,
                      isNumberMode: isNumberMode,
                      onSelected: _onNumberSelected,
                      onTextChanged: (text) {
                        setState(() {
                          this.isNumberEmpty = text.isEmpty;
                        });
                      },
                    )
                  ],
                )
              ),
            ),
            PaymentBottomBar(
              centerText: '저장',
              isActive: !isNumberEmpty,
              onSelected: () => _onBottomSelected(),
              isVisible: isChanged,
            )
          ],
        ),
      ),
    );
  }

  void _onSwitchSelected() {
    setState(() {
      this.isChanged = true;
      this.viewIsIssueCashReceipt = !viewIsIssueCashReceipt;
    });
  }

  void _onNumberSelected() {
    setState(() {
      this.isChanged = true;
      this.isNumberMode = true;
    });
  }

  void _onBottomSelected() {
    Provider.of<PaymentModel>(context, listen: false)
    ..saveIsIssueCashReceipt(this.viewIsIssueCashReceipt)
    ..saveCashReceiptType(this.viewCashReceiptType)
    ..saveCashReceiptNumber(_textEditingController.text);

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

  void _showModal() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        ),
        context: context,
        builder: (context) {
          return PaymentCashReceiptTypeModal(
            cashReceiptType: this.viewCashReceiptType,
            onSelected: (CashReceiptType resultType) {
              Navigator.pop(context);
              setState(() {
                this.isChanged = true;
                this.viewCashReceiptType = resultType;
              });
            },
          );
        }
    );
  }
}
