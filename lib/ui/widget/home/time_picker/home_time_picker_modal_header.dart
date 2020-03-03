import 'package:flutter/material.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';

class HomeTimePickerModalHeader extends StatelessWidget {

  final String textOrderDate;
  final Function onSelectedDatePicker;

  HomeTimePickerModalHeader({this.textOrderDate, this.onSelectedDatePicker});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            child: GestureDetector(
              onTap: onSelectedDatePicker,
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
            ),
          ),
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: (){
                Navigator.of(context).pop();
              }
          ),
        ]
    );
  }
}
