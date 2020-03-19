import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:provider/provider.dart';

class StoreSlideFloatingPanelHeaderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
          child: Consumer<CartModel>(
            builder: (_, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.left,
                        softWrap: true,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '${model.cart.detail.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' (으)로 배달'),
                          ],
                        ),
                      ),
                      Text('수정', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: titleFontSize))
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 3.0)),
                  Text(
                    '${_textDate(model.cart.orderDate)} ${_textTime(model.cart.orderTime.arrivalTime)} 도착',
                    style: TextStyle(fontSize: 14, color: subTextColor)
                  ),
                ],
              );
            },
          ),
        ),
        Divider(height: 40.0, thickness: 8.0, color: Colors.black.withOpacity(0.03))
      ],
    );
  }

  String _textDate(DateTime dt) {
    DateTime today = DateTime.now();
    if(dt.year == today.year && dt.month == today.month && dt.day == today.day) {
      return '오늘';
    }
    return DateFormat('yyyy년 MM월 dd일').format(dt);
  }

  String _textTime(String time) {
    List<String> t = time.split(':');
    String textHour = '${t[0]}시';
    String textMinute = t[1] == '00' ? '' : ' ${t[1]}분';
    return textHour + textMinute;
  }
}
