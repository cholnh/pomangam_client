import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class PaymentPointLogItemWidget extends StatelessWidget {

  final String title;
  final String subTitle;
  final String trailingText;

  PaymentPointLogItemWidget({this.title, this.subTitle, this.trailingText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            title:  Text(
              '$title',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)
            ),
            subtitle: Text(
              '$subTitle',
              style: TextStyle(fontSize: 12.0, color: subTextColor),
            ),
            trailing: Text(
              '$trailingText',
              style: TextStyle(fontSize: 14.0, color: primaryColor),
            ),
          ),
          Divider(height: 0.5)
        ],
      ),
    );
  }
}
