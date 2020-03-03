import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class HomeDatePicker extends StatelessWidget {

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onSelectedDate;

  HomeDatePicker({this.initialDate, this.firstDate, this.lastDate, this.onSelectedDate});

  @override
  Widget build(BuildContext context) {
    return CalendarCarousel<Event>(
      locale: 'ko',
      onDayPressed: (DateTime date, List<Event> events) => onSelectedDate(date),
      thisMonthDayBorderColor: Colors.white,
      weekendTextStyle: TextStyle(color: Colors.black),
      height: 420.0,
      selectedDateTime: initialDate,
      minSelectedDate: firstDate,
      maxSelectedDate: lastDate,
      selectedDayBorderColor: primaryColor,
      selectedDayButtonColor: backgroundColor,
      selectedDayTextStyle: TextStyle(color: Colors.black),
      daysHaveCircularBorder: false,
      todayButtonColor: Colors.white,
      todayBorderColor: Colors.white,
      todayTextStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      headerTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20.0),
      leftButtonIcon: Icon(Icons.chevron_left, color: Colors.black),
      rightButtonIcon: Icon(Icons.chevron_right, color: Colors.black),
    );
  }
}

