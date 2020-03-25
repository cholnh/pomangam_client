import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/i18n/i18n.dart';

class HomeTimePickerModalHeaderWidget extends StatelessWidget {

  final bool isOrderDateMode;
  final String textOrderDate;
  final Function onSelectedDatePicker;

  HomeTimePickerModalHeaderWidget({this.isOrderDateMode, this.textOrderDate, this.onSelectedDatePicker});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelectedDatePicker,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0, bottom: 25.0),
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${Messages.timePickerTitle}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(isOrderDateMode ? '시간변경' : '날짜변경', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: titleFontSize))
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 5.0)),
              Text('$textOrderDate', style: const TextStyle(fontSize: 14.0))
            ],
          ),
        ),
      ),
    );
  }
}
