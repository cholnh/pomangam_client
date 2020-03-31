import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/domains/user/point_log/point_log.dart';
import 'package:pomangam_client/domains/user/point_log/point_type.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/point/point_model.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:pomangam_client/views/pages/payment/point/payment_point_page_type.dart';
import 'package:pomangam_client/views/widgets/payment/payment_app_bar.dart';
import 'package:pomangam_client/views/widgets/payment/point/payment_point_add_widget.dart';
import 'package:pomangam_client/views/widgets/payment/point/payment_point_log_item_widget.dart';
import 'package:provider/provider.dart';

class PaymentPointPage extends StatefulWidget {
  @override
  _PaymentPointPageState createState() => _PaymentPointPageState();
}

class _PaymentPointPageState extends State<PaymentPointPage> {

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    Provider.of<PointModel>(context, listen: false).fetch();
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);
    _textEditingController.text = cartModel.usingPoint <= 0 ? '' : cartModel.usingPoint.toString();
  }

  @override
  Widget build(BuildContext context) {
    PaymentPointPageType pageType = ModalRoute.of(context).settings?.arguments ?? PaymentPointPageType.FROM_SETTING;
    SignInModel signInModel = Provider.of<SignInModel>(context);

    return Scaffold(
      appBar: PaymentAppBar(
        context,
        title: '보유포인트 ${StringUtils.comma(signInModel.userInfo.userPoint)}P',
        leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            pageType == PaymentPointPageType.FROM_PAYMENT
            ? PaymentPointAddWidget(
              textEditingController: _textEditingController,
              userPoint: signInModel.userInfo.userPoint,
              onSelected: _onSelected,
            )
            : Container(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('포인트 이용내역', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
                  Text('최근 1년 내역', style: TextStyle(fontSize: 12.0, color: subTextColor)),
                ],
              ),
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
                            index: index,
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
            ),
          ],
        ),
      )
    );
  }

  void _onSelected() {
    SignInModel signInModel = Provider.of<SignInModel>(context, listen: false);
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);

    int usingPoint = int.tryParse(_textEditingController.text) ?? 0;
    if(usingPoint > signInModel.userInfo.userPoint) {
      usingPoint = signInModel.userInfo.userPoint;
    }
    if(usingPoint <= 0) {
      usingPoint = 0;
    }
    cartModel.usingPoint = usingPoint;

    Navigator.pop(context);

    // toast 메시지
    Fluttertoast.showToast(
        msg: "적용완료",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: titleFontSize
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
        trailingText = '+ ${StringUtils.comma(pointLog.point)}P 적립';
        break;
      case PointType.ROLLBACK_BY_PAYMENT_CANCEL:
      case PointType.USED_BY_BUY:
      case PointType.UPDATED_MINUS_BY_ADMIN:
        trailingText = '- ${StringUtils.comma(pointLog.point)}P 차감';
        break;

    }
    return trailingText;
  }

  String _dateFormat(DateTime dt) {
    return DateFormat('yyyy.MM.dd').format(dt);
  }
}
