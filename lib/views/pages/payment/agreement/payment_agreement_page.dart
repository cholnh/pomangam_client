import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/providers/policy/policy_model.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:provider/provider.dart';

class PaymentAgreementPage extends StatefulWidget {
  @override
  _PaymentAgreementPageState createState() => _PaymentAgreementPageState();
}

class _PaymentAgreementPageState extends State<PaymentAgreementPage> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    Provider.of<PolicyModel>(context, listen: false)
    ..privacy()
    ..terms();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PaymentAppBar(
          context,
          title: '주문/결제/약관에 관한 동의',
          leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Consumer<PolicyModel>(
            builder: (_, policyModel, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('개인정보 처리방침', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
                  Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                  SizedBox(
                    height: 100.0,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Html(
                        data: policyModel.htmlPrivacy ?? '',
                        backgroundColor: Color.fromRGBO(0xee, 0xee, 0xee, 1.0),
                        padding: const EdgeInsets.all(5.0),
                        defaultTextStyle: TextStyle(fontSize: 12.0),
                        customTextStyle: (dom.Node node, TextStyle baseStyle) {
                          if (node is dom.Element) {
                            switch (node.className) {
                              case 'title': return baseStyle.merge(TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0));
                              case 'outer': return baseStyle.merge(TextStyle(fontWeight: FontWeight.bold, fontSize: 9.0));
                              case 'inner': return baseStyle.merge(TextStyle(fontSize: 9.0));
                            }
                          }
                          return baseStyle;
                        }
                      )
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(bottom: 20.0)),
                  Text('전자상거래 표준약관', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
                  Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                  SizedBox(
                    height: 100.0,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Html(
                        data: policyModel.htmlTerms ?? '',
                        backgroundColor: Color.fromRGBO(0xee, 0xee, 0xee, 1.0),
                        padding: const EdgeInsets.all(5.0),
                        defaultTextStyle: TextStyle(fontSize: 12.0),
                        customTextStyle: (dom.Node node, TextStyle baseStyle) {
                          if (node is dom.Element) {
                            switch (node.className) {
                              case 'title': return baseStyle.merge(TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0));
                              case 'outer': return baseStyle.merge(TextStyle(fontWeight: FontWeight.bold, fontSize: 9.0));
                              case 'inner': return baseStyle.merge(TextStyle(fontSize: 9.0));
                            }
                          }
                          return baseStyle;
                        }
                      )
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(bottom: 20.0)),
                  Center(
                    child: Text(
                      '포만감은 통신판매중개자로서 통신판매의 당사자가 아니며, 판매자가 등록한 상품 정보, 상품의 품질 및 거래에 대해서 일체의 책임을 지지 않습니다.',
                      style: TextStyle(fontSize: 12.0, color: subTextColor)),
                  ),
                  Padding(padding: const EdgeInsets.only(bottom: 40.0)),
                  Consumer<PaymentModel>(
                    builder: (_, paymentModel, __) {
                      bool isPaymentAgree = paymentModel.payment?.isPaymentAgree == null ? false : paymentModel.payment?.isPaymentAgree;
                      return Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('위 내용에 대해 동의합니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
                              !isPaymentAgree || paymentModel.payment?.paymentAgreeDate == null
                              ? Container()
                              : Text(' (${_agreementDate(paymentModel.payment.paymentAgreeDate)} 동의 완료)', style: TextStyle(fontSize: 11.0, color: subTextColor)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => isPaymentAgree ? {} : _onSelected(paymentModel, true),
                                child: Material(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: isPaymentAgree
                                      ),
                                      Text(
                                          '동의',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => !isPaymentAgree ? {} : _onSelected(paymentModel, false),
                                child: Material(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: !isPaymentAgree
                                      ),
                                      Text(
                                        '동의 안 함',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _agreementDate(DateTime dt) {
    return DateFormat('yyyy.MM.dd').format(dt);
  }

  void _onSelected(PaymentModel model, bool isPaymentAgree) async {
    await model.savePaymentAgreeDate(DateTime.now());
    await model.saveIsPaymentAgree(isPaymentAgree, notify: true);

    if(isPaymentAgree) {
      Future.delayed(Duration(milliseconds: 300), () {
        Fluttertoast.showToast(
            msg: '${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())} 약관 동의 완료',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            fontSize: titleFontSize
        );
        Navigator.pop(context);
      });
    }
  }
}
