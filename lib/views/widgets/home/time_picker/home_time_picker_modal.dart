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
      child: Consumer<OrderTimeModel>(
        builder: (_, model, child) {
          var textOrderDate = DateFormat('yyyy-MM-dd').format(model.viewUserOrderDate);
          return model.isOrderDateMode
            ? HomeDatePicker(
                initialDate: model.viewUserOrderDate,
                firstDate:  DateTime.now() - 1.days,
                lastDate:  DateTime.now() + 7.days,
                onSelectedDate: (date) => _onSelectedDate(date),
              )
            : Column(
                children: <Widget>[
                  HomeTimePickerModalHeaderWidget(
                    textOrderDate: '$textOrderDate',
                    onSelectedDatePicker: () => model.changeOrderDateMode(true),
                  ),
                  const Divider(height: 0.1, color: Colors.black),
                  HomeTimePickerModalItemWidget(
                      model: model, 
                      onSelected: widget.onSelected
                  ),
                ],
              );
        }
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
}
