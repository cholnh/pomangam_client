import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/order/time/order_time.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';

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
          OrderTime orderTime = model.orderTimes[index];

          if(!isNextDay && orderTime.getOrderEndDateTime().isBefore(DateTime.now())) {
            return Container();
          }
          int h = orderTime.getArrivalDateTime().hour;
          int m = orderTime.getArrivalDateTime().minute;
          var textMinute = m == 0 ? '' : '$m분 ';
          var textArrivalTime = '$h시 $textMinute' + (isNextDay ? '예약' : '도착');
          return Container(
            child: ListTile(
              title: orderTime.idx != model.userOrderTime.idx
                  ? Center(child: Text('$textArrivalTime'))
                  : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('$textArrivalTime'),
                      model.isOrderDateChanged ? Container() : const Padding(padding: EdgeInsets.all(3)),
                      model.isOrderDateChanged ? Container() : const Icon(Icons.check, color: primaryColor)
                    ],
                  )
              ),
              onTap: () {
                DateTime changedOrderDate = model.viewUserOrderDate;
                model.changeUserOrderDate(changedOrderDate);
                model.changeUserOrderTime(orderTime);
                onSelected(oIdx: orderTime.idx, changedOrderDate: changedOrderDate);
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.1),
      ),
    );
  }
}
