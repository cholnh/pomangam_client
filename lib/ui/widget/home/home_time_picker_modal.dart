import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';
import 'package:pomangam_client/domain/order/time/order_time.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:provider/provider.dart';
import 'package:time/time.dart';

class HomeTimePickerModal extends StatefulWidget {

  final Function onSelected;

  HomeTimePickerModal({this.onSelected});

  @override
  _HomeTimePickerModalState createState() => _HomeTimePickerModalState();
}

class _HomeTimePickerModalState extends State<HomeTimePickerModal> {

  @override
  void initState() {
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    orderTimeModel.isOrderDateChanged = false;
    orderTimeModel.viewUserOrderDate = orderTimeModel.userOrderDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Opacity(
                    opacity: 0.0,
                    child: const IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: null,
                    )
                ),
                Flexible(
                  child: Consumer<OrderTimeModel>(
                    builder: (_, model, child) {
                      var textOrderDate = DateFormat('yyyy-MM-dd').format(model.viewUserOrderDate);
                      return GestureDetector(
                        onTap: () => picker(context: context, model: model),
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 12.0)),
                            Text(
                                '${Messages.timePickerTitle}',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.access_time, size: 18.0),
                                  Padding(padding: EdgeInsets.only(left: 6.0)),
                                  Text('$textOrderDate')
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 12.0))
                          ],
                        ),
                      );
                    }
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                ),
              ]
          ),
          const Divider(height: 0.1, color: Colors.black),
          Expanded(
            child: Consumer<OrderTimeModel>(
              builder: (_, model, child) {
                OrderTime userOrderTime = model.userOrderTime;
                DateTime viewUserOrderDate = model.viewUserOrderDate;

                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: model.orderTimes.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isNextDay = viewUserOrderDate.isAfter(DateTime.now());
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
                        title: orderTime.idx != userOrderTime.idx
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
                          widget.onSelected(oIdx: orderTime.idx, changedOrderDate: changedOrderDate);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.1),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  void picker({BuildContext context, OrderTimeModel model}) async {
    DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale('ko', 'KO'),
      initialDate: model.viewUserOrderDate,
      firstDate:  DateTime.now() - 1.days,
      lastDate:  DateTime.now() + 7.days,
//      selectableDayPredicate: (DateTime val)
//        => val.weekday == 6 || val.weekday == 7 ? true : false,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          child: child,
        );
      }
    );
    if(picked != null) {
      model.changeViewUserOrderDate(picked);
    }
  }
}
