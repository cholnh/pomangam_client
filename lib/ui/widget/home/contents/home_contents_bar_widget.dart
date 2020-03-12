import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/ui/widget/home/sort_picker/home_sort_picker_modal.dart';
import 'package:pomangam_client/ui/widget/home/time_picker/home_time_picker_modal.dart';
import 'package:provider/provider.dart';

class HomeContentsBarWidget extends StatefulWidget {

  final Function onChangedTime;

  HomeContentsBarWidget({this.onChangedTime});

  @override
  _HomeContentsBarWidgetState createState() => _HomeContentsBarWidgetState();
}

class _HomeContentsBarWidgetState extends State<HomeContentsBarWidget> {
  int sort = 0;
  int dIdx;
  DateTime oDate;

  @override
  void initState() {
    super.initState();
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    dIdx = deliverySiteModel.userDeliverySite?.idx;
    oDate = orderTimeModel.userOrderDate;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: PmgKeys.deliveryContentsBar,
      backgroundColor: backgroundColor,
      floating: false,
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 0.8,
      title: Consumer<OrderTimeModel>(
        builder: (_, model, child) {
          bool isNextDay = model.userOrderDate?.isAfter(DateTime.now());
          var textArrivalDate = isNextDay ? ' (${DateFormat('MM월 dd일').format(model.userOrderDate)}) ' : '';
          int h = model.userOrderTime.getArrivalDateTime().hour;
          int m = model.userOrderTime.getArrivalDateTime().minute;
          var textMinute = m == 0 ? '' : '$m분 ';
          var textArrivalTime = '$h시 $textMinute' + (isNextDay ? '예약' : '도착');
          return InkWell(
            child: Row(
              children: <Widget>[
                Text('$textArrivalTime$textArrivalDate', style: const TextStyle(fontSize: appBarFontSize, color: Colors.black)),
                Icon(Icons.arrow_drop_down, color: Colors.black)
              ],
            ),
            onTap: () => _showModal(
                widget: HomeTimePickerModal(onSelected: _selectTime)
            )
          );
        }
      ),
      actions: <Widget>[
//        const IconButton(
//          icon: const Icon(Icons.view_module, color: Colors.grey),
//        ),
        IconButton(
          icon: const Icon(Icons.filter_list, color: Colors.grey),
          onPressed: () => _showModal(
              widget: HomeSortPickerModal(sort: sort, onSelected: _selectSort)
          ),
        )
      ],
    );
  }

  _showModal({Widget widget}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (context) {
          return widget;
        }
    );
  }

  _selectTime({int oIdx, DateTime changedOrderDate}) {
    Navigator.pop(context);
    Provider.of<StoreSummaryModel>(context, listen: false)
      ..clearWithNotify()
      ..fetch(
          isForceUpdate: true,
          dIdx: dIdx,
          oIdx: oIdx,
          oDate: changedOrderDate
      );
    widget.onChangedTime();
  }

  _selectSort(sort) {
    Navigator.pop(context);
    setState(() {
      this.sort = sort;
    });
  }
}
