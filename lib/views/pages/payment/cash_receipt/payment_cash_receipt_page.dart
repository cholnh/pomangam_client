import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/views/widgets/payment/cash_receipt/payment_cash_receipt_type_modal.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: PaymentAppBar(
          context,
          title: '현금영수증',
          leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Consumer<PaymentModel>(
                  builder: (_, paymentModel, __) {
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _onSwitchSelected(paymentModel),
                          child: Material(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('현금영수증 발급', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Switch(
                                      value: viewIsIssueCashReceipt,
                                      inactiveTrackColor: viewIsIssueCashReceipt ? primaryColor : subTextColor,
                                      inactiveThumbColor: Colors.white,
                                    )
                                  ],
                                ),
                                Divider(height: 10.0)
                              ],
                            ),
                          ),
                        ),
                        viewIsIssueCashReceipt
                        ? GestureDetector(
                          onTap: () => _showModal(),
                          child: Material(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('종류', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('${convertCashReceiptTypeToText(viewCashReceiptType)}', style: TextStyle(fontSize: 14.0)),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(height: 10.0)
                              ],
                            ),
                          ),
                        )
                        : Container(),
                        viewIsIssueCashReceipt
                        ? GestureDetector(
                          onTap: () => _onNumberSelected(),
                          child: Material(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('번호', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    isNumberMode
                                    ? Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20.0),
                                        child: TextFormField(
                                          controller: _textEditingController,
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          autofocus: true,
                                          expands: false,
                                          keyboardType: TextInputType.number,
                                          cursorColor: primaryColor,
                                          style: TextStyle(fontSize: 14.0),
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: backgroundColor),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: backgroundColor),
                                            ),
                                          ),
                                          onChanged: (text) {
                                            setState(() {
                                              this.isNumberEmpty = text.isEmpty;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                    : Row(
                                      children: <Widget>[
                                        Text('$viewCashReceiptNumber', style: TextStyle(fontSize: 14.0)),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(height: 10.0)
                              ],
                            ),
                          ),
                        ): Container()
                      ],
                    );
                  }
                )
              ),
            ),
            isChanged
            ? PaymentBottomBar(
              centerText: '저장',
              isActive: !isNumberEmpty,
              onSelected: () => _onBottomSelected(context),
            )
            : Container()
          ],
        ),
      ),
    );
  }

  void _onSwitchSelected(PaymentModel model) {
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

  void _onBottomSelected(BuildContext context) {
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
