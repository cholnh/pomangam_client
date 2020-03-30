import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/key/pmg_key.dart';
import 'package:pomangam_client/domains/sort/sort_type.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:pomangam_client/providers/sort/home_sort_model.dart';
import 'package:pomangam_client/providers/store/store_summary_model.dart';
import 'package:pomangam_client/views/widgets/home/sort_picker/home_sort_picker_modal.dart';
import 'package:pomangam_client/views/widgets/home/time_picker/home_time_picker_modal.dart';
import 'package:provider/provider.dart';

class HomeContentsBarWidget extends StatefulWidget {

  final Function onChangedTime;
  final Function onChangedSort;

  HomeContentsBarWidget({this.onChangedTime, this.onChangedSort});

  @override
  _HomeContentsBarWidgetState createState() => _HomeContentsBarWidgetState();
}

class _HomeContentsBarWidgetState extends State<HomeContentsBarWidget> {

  int dIdx;
  int oIdx;
  DateTime oDate;

  @override
  void initState() {
    super.initState();
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    dIdx = deliverySiteModel.userDeliverySite?.idx;
    oIdx = orderTimeModel.userOrderTime?.idx;
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
          var textArrivalDate = isNextDay ? ' (${DateFormat('MM월 dd일').format(model.userOrderDate)})' : '';
          int h = model.userOrderTime.getArrivalDateTime().hour;
          int m = model.userOrderTime.getArrivalDateTime().minute;
          var textMinute = m == 0 ? '' : '$m분 ';
          var textArrivalTime = '$h시 $textMinute' + (isNextDay ? '예약' : '도착');
          return InkWell(
            child: Row(
              children: <Widget>[
                Text('$textArrivalTime$textArrivalDate', style: const TextStyle(fontSize: appBarFontSize, color: Colors.black)),
                Icon(Icons.arrow_drop_down, color: primaryColor)
              ],
            ),
            onTap: () => _showModal(
                widget: HomeTimePickerModal(onSelected: widget.onChangedTime)
            )
          );
        }
      ),
      actions: <Widget>[
        Consumer<HomeSortModel>(
          builder: (_, sortModel, __) {
            SortType sortType = sortModel.sortType;
            return GestureDetector(
              onTap: () => _showModal(
                  widget: HomeSortPickerModal(type: sortType, onSelected: _selectSort)
              ),
              child: Material(
                child: Row(
                  children: <Widget>[
                    Center(child: Text('${convertSortTypeToText(sortType)}', style: TextStyle(fontSize: 10.0, color: subTextColor))),
                    Padding(padding: const EdgeInsets.only(right: 3.0)),
                    Icon(Icons.filter_list, color: subTextColor),
                    Padding(padding: const EdgeInsets.only(right: 11.0))
                  ],
                ),
              )
            );
          }
        )
      ],
    );
  }

  void _showModal({Widget widget}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))
      ),

      isScrollControlled: true,
      context: context,
      builder: (context) {
        return widget;
      }
    );
  }

  void _selectSort(SortType sortType) async {
    Navigator.pop(context);

    Provider.of<HomeSortModel>(context, listen: false)
      .changeSortType(sortType, notify: true);

    // store summary fetch
    Provider.of<StoreSummaryModel>(context, listen: false)
    ..clearWithNotify()
    ..fetch(
      isForceUpdate: true,
      dIdx: dIdx,
      oIdx: oIdx,
      oDate: oDate,
      sortType: sortType
    );

    widget.onChangedSort();
  }
}
