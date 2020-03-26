import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:pomangam_client/views/widgets/payment/point/payment_point_log_item_widget.dart';

class PaymentPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PaymentAppBar(
          context,
          title: '포인트',
          leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('보유포인트', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
                        Text(' ${StringUtils.comma(3600)}원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: primaryColor)),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.only(bottom: 5.0)),
                    Text('이번 달 소멸 예정포인트 0원', style: TextStyle(fontSize: 13.0, color: subTextColor)),
                  ],
                ),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('포인트 이용내역', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
                        Text('최근 1년 내역', style: TextStyle(fontSize: 12.0, color: subTextColor)),
                      ],
                    ),
                  )
                ]
            ),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return PaymentPointLogItemWidget(
                        title: '한솥도시락',
                        subTitle: '2020.03.21 (2021.03.20 만료)',
                        trailingText: '+ 200포인트 적립'
                      );
                    }, childCount: 12)
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
