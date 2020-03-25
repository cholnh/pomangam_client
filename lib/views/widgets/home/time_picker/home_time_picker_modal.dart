import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:pomangam_client/views/widgets/home/time_picker/home_date_picker_modal.dart';
import 'package:pomangam_client/views/widgets/home/time_picker/home_time_picker_modal_header_widget.dart';
import 'package:pomangam_client/views/widgets/home/time_picker/home_time_picker_modal_item_widget.dart';
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
    super.initState();
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    orderTimeModel.isOrderDateMode = false;
    orderTimeModel.isOrderDateChanged = false;
    orderTimeModel.viewUserOrderDate = orderTimeModel.userOrderDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 470.0,
        child: Consumer<OrderTimeModel>(
          builder: (_, model, child) {
            String textOrderDate = DateFormat('yyyy년 MM월 dd일').format(model.viewUserOrderDate);
            String subTextOrderDate = _subTextOrderDate(model.viewUserOrderDate);
            return Column(
              children: <Widget>[
                HomeTimePickerModalHeaderWidget(
                  isOrderDateMode: model.isOrderDateMode,
                  textOrderDate: '$textOrderDate $subTextOrderDate',
                  onSelectedDatePicker: () => model.changeOrderDateMode(!model.isOrderDateMode),
                ),
                Divider(height: 0.0, thickness: 8.0, color: Colors.black.withOpacity(0.03)),
                model.isOrderDateMode
                ? HomeDatePicker(
                    initialDate: model.viewUserOrderDate,
                    firstDate:  DateTime.now() - 1.days,
                    lastDate:  DateTime.now() + 7.days,
                    onSelectedDate: (date) => _onSelectedDate(date),
                )
                : HomeTimePickerModalItemWidget(
                    model: model,
                    onSelected: widget.onSelected
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  void _onSelectedDate(DateTime date) {
    OrderTimeModel model = Provider.of<OrderTimeModel>(context, listen: false);
    model.changeOrderDateMode(false);
    if(date != null) {
      model.changeViewUserOrderDate(date);
    }
  }

  String _subTextOrderDate(DateTime dt) {
    bool isToday = _isToday(dt);
    bool isTomorrow = _isTomorrow(dt);
    if(isToday) {
      return '(오늘)';
    } else if(isTomorrow) {
      return '(내일)';
    } else {
      return '';
    }
  }

  bool _isToday(DateTime dt) {
    DateTime now = DateTime.now();
    return dt.year == now.year && dt.month == now.month && dt.day == now.day;
  }

  bool _isTomorrow(DateTime dt) {
    DateTime tomorrow = 1.days.fromNow;
    return dt.year == tomorrow.year && dt.month == tomorrow.month && dt.day == tomorrow.day;
  }
}
