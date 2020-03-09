import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class ProductBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Container(
        color: primaryColor,
        child: Center(
          child: Text('카트에 추가', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)),
        ),
      ),
    );
  }
}
