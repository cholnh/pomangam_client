import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/order/time/order_time.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:pomangam_client/providers/store/store_summary_model.dart';
import 'package:provider/provider.dart';

class HomeTimePickerModalItemWidget extends StatelessWidget {

  final OrderTimeModel model;
  final Function onSelected;

  HomeTimePickerModalItemWidget({this.model, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: model.orderTimes.length,
        itemBuilder: (BuildContext context, int index) {
          bool isNextDay = model.viewUserOrderDate.isAfter(DateTime.now());
          bool isSameDay =
              model.viewUserOrderDate.year == model.userOrderDate.year &&
                  model.viewUserOrderDate.month == model.userOrderDate.month &&
                  model.viewUserOrderDate.day == model.userOrderDate.day;

          OrderTime orderTime = model.orderTimes[index];

          if(!isNextDay && orderTime.getOrderEndDateTime().isBefore(DateTime.now())) {
            return Container();
          }
          int h = orderTime.getArrivalDateTime().hour;
          int m = orderTime.getArrivalDateTime().minute;
          var textMinute = m == 0 ? '' : '$m분 ';
          var textArrivalTime = '$h시 $textMinute' + (isNextDay ? '예약' : '도착');
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              title: orderTime.idx != model.userOrderTime.idx
                ? Text('$textArrivalTime', style: TextStyle(fontSize: 14.0))
                : Row(
                  children: <Widget>[
                    Text(
                      '$textArrivalTime',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: isSameDay ? FontWeight.bold : FontWeight.normal,
                        color: isSameDay ? primaryColor : Colors.black
                      )
                    ),
                    isSameDay ? const Padding(padding: EdgeInsets.all(3)) : Container(),
                    isSameDay ? const Icon(Icons.check, color: primaryColor, size: 18.0) : Container()
                  ],
                ),
              onTap: () => _onSelected(context, orderTime, isSameDay),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.1),
      ),
    );
  }

  void _onSelected(BuildContext context, OrderTime orderTime, bool isSameDay) {
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);

    if(cartModel.cart.items.isEmpty) {
      Navigator.pop(context);
      _dialogOk(context, orderTime, false);
    } else {
      if(!isSameDay || cartModel.cart.orderTime.idx != orderTime.idx) {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) => CupertinoAlertDialog(
            title: Text(''),
            content: Column(
              children: <Widget>[
                Text('주문시간이 달라 장바구니가 초기화됩니다.'),
                Text('계속하시겠습니까?'),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('확인'),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                  _dialogOk(context, orderTime, true);
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('취소'),
                onPressed: () => Navigator.pop(dialogContext),
              )
            ],
          ),
        );
      }
    }
  }

  void _dialogOk(BuildContext context, OrderTime orderTime, bool cartClear) {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);

    // user Date 변경
    DateTime changedOrderDate = model.viewUserOrderDate;
    model.changeUserOrderDate(changedOrderDate);
    model.changeUserOrderTime(orderTime);

    // 메인화면 StoreSummary 리스트 re-fetch
    Provider.of<StoreSummaryModel>(context, listen: false)
    ..clearWithNotify()
    ..fetch(
        isForceUpdate: true,
        dIdx: deliverySiteModel.userDeliverySite?.idx,
        oIdx: orderTime.idx,
        oDate: changedOrderDate
    );

    // cart 정보 초기화
    if(cartClear) {
      cartModel.clear(notify: true);
    }
    cartModel.cart
      ..orderDate = changedOrderDate
      ..orderTime = orderTime;

    // HomePage._onChangedTime() 실행
    this.onSelected();
  }
}
