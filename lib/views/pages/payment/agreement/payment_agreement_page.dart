import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/providers/policy/policy_model.dart';
import 'package:pomangam_client/views/pages/payment/agreement/payment_agreement_page_type.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:pomangam_client/views/widgets/payment/payment_bottom_bar.dart';
import 'package:provider/provider.dart';

class PaymentAgreementPage extends StatefulWidget {
  @override
  _PaymentAgreementPageState createState() => _PaymentAgreementPageState();
}

class _PaymentAgreementPageState extends State<PaymentAgreementPage> {

  ScrollController _scrollController = ScrollController();
  bool isFetched;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    PolicyModel policyModel = Provider.of<PolicyModel>(context, listen: false)
    ..htmlPrivacy = null
    ..htmlTerms = null;
    isFetched = false;

    _scrollController.addListener(() async {
      if(!isFetched) {
        isFetched = true;
        await policyModel.privacy();
        await policyModel.terms();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PaymentAgreementPageType pageType = ModalRoute.of(context).settings?.arguments ?? PaymentAgreementPageType.FROM_PAYMENT;

    return Scaffold(
      appBar: PaymentAppBar(
        context,
        title: '주문/결제/약관에 관한 동의',
        leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
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
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          child: Html(
                            data: policyModel.htmlPrivacy ?? _dummyPrivacy(),
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
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          child: Html(
                            data: policyModel.htmlTerms ?? _dummyTerms(),
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
                          bool isFirstSelect = pageType == PaymentAgreementPageType.FROM_CART;
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
                                    onTap: () => isFirstSelect
                                      ? _onSelected(true)
                                      : isPaymentAgree ? {} : _onSelected(true),
                                    child: Material(
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: isFirstSelect ? false : isPaymentAgree
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
                                    onTap: () => isFirstSelect
                                      ? _onSelected(false)
                                      : !isPaymentAgree ? {} : _onSelected(false),
                                    child: Material(
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: isFirstSelect ? false : !isPaymentAgree
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
            pageType == PaymentAgreementPageType.FROM_CART
            ? PaymentBottomBar(
              centerText: '동의합니다',
              onSelected: () => _onSelected(true),
            )
            : Container()
          ],
        ),
      ),
    );
  }

  String _agreementDate(DateTime dt) {
    return DateFormat('yyyy.MM.dd').format(dt);
  }

  void _onSelected(bool isPaymentAgree) async {
    PaymentModel model = Provider.of<PaymentModel>(context, listen: false);

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

  String _dummyPrivacy() {
    return
      '''
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <style>
              body{
                  text-align:left!important;
                  background-color: #eeeeee;
                  color: #666666;
              }
              .contents{
                  margin:auto;
              }
              .title{
                  font-size:11px;
                  font-weight:bold;
              }
              .outer{
                  font-size:9px;
                  font-weight: bold;
              }
              .inner{
                  font-size:9px;
                  font-weight: lighter;
              }
          </style>
          <meta charset="UTF-8">
          <title>개인정보 처리방침</title>
      </head>
      <body>
          <div class="title">개인정보 처리방침</div><br>
          <div class="outer">제1조(개인정보의 처리 목적)</div>
          <div class="inner">
              <미스터포터>(‘www.pomangam.com’이하 ‘포만감’) 은(는) 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다. <br>
                  - 고객 가입의사 확인, 고객에 대한 서비스 제공에 따른 본인 식별.인증, 회원자격 유지.관리, 물품 또는 서비스 공급에 따른 금액 결제, 물품 또는 서비스의 공급.배송 등<br>
          </div><br>
      </body>
      </html>
      ''';
  }

  String _dummyTerms() {
    return
      '''
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <style>
              body{
                  text-align:left!important;
                  background-color: #eeeeee;
                  color: #666666;
              }
              .contents{
                  margin:auto;
              }
              .title{
                  font-size:11px;
                  font-weight:bold;
              }
              .outer{
                  font-size:9px;
                  font-weight: bold;
              }
              .inner{
                  font-size:9px;
                  font-weight: lighter;
              }
          </style>
          <meta charset="UTF-8">
          <title>전자상거래(인터넷사이버몰) 표준약관</title>
      </head>
      <body>
          <div class="title">전자상거래(인터넷사이버몰) 표준약관</div><br>
          <div class="outer">
              표준약관 제10023호<br>
              (2015. 6. 26. 개정)
          </div><br>
      
          <div class="outer">제1조(목적)</div>
          <div class="inner">
              이 약관은 미스터포터 회사(전자상거래 사업자)가 운영하는 포만감 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.<br>
              ※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」
          </div><br>
      </body>
      </html>
      ''';
  }
}
