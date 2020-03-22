import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:pomangam_client/views/widgets/payment/payment_bottom_bar.dart';
import 'package:pomangam_client/views/widgets/payment/payment_item_widget.dart';

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
    return Scaffold(
      appBar: PaymentAppBar(context),
      bottomNavigationBar: PaymentBottomBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('결제금액', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
                    Text(' 5,000원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: primaryColor)),
                  ],
                ),
              ),
            ),
          ),
          PaymentItemWidget(
            title: '결제수단',
            subTitle: '신용/체크 카드',
            onSelected: () => print('결제수단 누름'),
          ),
          PaymentItemWidget(
            title: '포인트',
            subTitle: '3,400원 사용가능',
            onSelected: () => print('포인트 누름'),
            isActive: false,
          ),
          PaymentItemWidget(
            title: '할인쿠폰',
            subTitle: '쿠폰코드를 입력 또는 선택해 주세요',
            onSelected: () => print('할인쿠폰 누름'),
          ),
          PaymentItemWidget(
            title: '현금영수증',
            subTitle: '개인소득공제 01012345678',
            onSelected: () => print('현금영수증 누름'),
          ),
          PaymentItemWidget(
            title: '주문/결제/약관에 관한 동의',
            subTitle: '2020년 3월 23일',
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('동의', style: TextStyle(color: primaryColor, fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
            onSelected: () => print('동의 누름'),
          ),
//          SliverToBoxAdapter(
//            child: Center(
//              child: Padding(
//                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                child: Text(
//                  '포만감은 통신판매중개자로서 통신판매의 당사자가 아니며, 판매자가 등록한 상품 정보, 상품의 품질 및 거래에 대해서 일체의 책임을 지지 않습니다.',
//                  style: TextStyle(fontSize: 12.0, color: subTextColor))
//              ),
//            ),
//          ),
        ],
      )
    );
  }

  void _init({bool isBuild = false}) async {

  }
}