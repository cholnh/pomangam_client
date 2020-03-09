import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class StoreBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Container(
        color: primaryColor,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text('① 카트', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0))
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text('3,500원', style: TextStyle(color: backgroundColor, fontSize: 14.0)),
              )
            ),
          ],
        ),
      ),
    );
  }
}
