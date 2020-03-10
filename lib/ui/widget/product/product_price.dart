import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class ProductPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
              '가격',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
              '3,500원',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)
          ),
        )
      ],
    );
  }
}
