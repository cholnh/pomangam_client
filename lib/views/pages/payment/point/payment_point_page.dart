import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/domains/user/point_log/point_log.dart';
import 'package:pomangam_client/domains/user/point_log/point_type.dart';
import 'package:pomangam_client/providers/point/point_model.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:pomangam_client/views/widgets/payment/point/payment_point_log_item_widget.dart';
import 'package:provider/provider.dart';

class PaymentPointPage extends StatefulWidget {
  @override
  _PaymentPointPageState createState() => _PaymentPointPageState();
}

class _PaymentPointPageState extends State<PaymentPointPage> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    Provider.of<PointModel>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    SignInModel signInModel = Provider.of<SignInModel>(context);

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
                        Text(' ${StringUtils.comma(signInModel.userInfo.userPoint)}원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: primaryColor)),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.only(bottom: 5.0)),
                    Text('1원 이상, 1원 단위로 사용 가능', style: TextStyle(fontSize: 13.0, color: subTextColor)),
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
              child: Consumer<PointModel>(
                builder: (_, pointModel, __) {
                  if(pointModel.isFetching) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: CupertinoActivityIndicator(),
                    );
                  }

                  List<PointLog> pointLogs = pointModel.pointLogs;
                  if(pointLogs.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('포인트 내역이 없습니다.', style: TextStyle(color: subTextColor, fontSize: 12.0)),
                    );
                  }
                  return CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            PointLog pointLog = pointLogs[index];
                            return PaymentPointLogItemWidget(
                                title: _pointLogTitle(pointLog),
                                subTitle: '${_dateFormat(pointLog.registerDate)} (${_dateFormat(pointLog.expiredDate)} 만료)',
                                trailingText: _pointLogTrailingText(pointLog)
                            );
                          }, childCount: pointLogs.length)
                      )
                    ],
                  );
                }
              ),
            )
          ],
        )
      ),
    );
  }

  String _pointLogTitle(PointLog pointLog) {
    switch(pointLog.pointType) {

      case PointType.ISSUED_BY_PROMOTION:
        return '프로모션 적립';
      case PointType.ISSUED_BY_BUY:
      case PointType.ROLLBACK_BY_PAYMENT_CANCEL:
      case PointType.USED_BY_BUY:
        return '주문번호 no.${pointLog.idxOrder}';
      case PointType.UPDATED_PLUS_BY_ADMIN:
        return '관리자에 의한 적립';
      case PointType.UPDATED_MINUS_BY_ADMIN:
        return '관리자에 의한 차감';

    }
    return '알 수 없음';
  }

  String _pointLogTrailingText(PointLog pointLog) {
    String trailingText = '';
    switch(pointLog.pointType) {

      case PointType.ISSUED_BY_PROMOTION:
      case PointType.ISSUED_BY_BUY:
      case PointType.UPDATED_PLUS_BY_ADMIN:
        trailingText = '+ ${StringUtils.comma(pointLog.point)}포인트 적립';
        break;
      case PointType.ROLLBACK_BY_PAYMENT_CANCEL:
      case PointType.USED_BY_BUY:
      case PointType.UPDATED_MINUS_BY_ADMIN:
        trailingText = '- ${StringUtils.comma(pointLog.point)}포인트 차감';
        break;

    }
    return trailingText;
  }

  String _dateFormat(DateTime dt) {
    return DateFormat('yyyy.MM.dd').format(dt);
  }
}
