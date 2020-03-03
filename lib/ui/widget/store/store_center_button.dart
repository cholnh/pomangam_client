import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class StoreCenterButton extends StatelessWidget {

  final int wPadding = 40;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width/2 - wPadding;
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 32.0,
            width: w,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.black12)
              ),
              color: backgroundColor,
              child: Container(
                child: Text('쿠폰받기', style: TextStyle(fontSize: 15.0, color: Colors.black), textAlign: TextAlign.center),
              ),
            ),
          ),
          SizedBox(
            height: 32.0,
            width: w,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.black12)
              ),
              color: backgroundColor,
              child: Container(
                child: Text('리뷰작성', style: TextStyle(fontSize: 15.0, color: Colors.black), textAlign: TextAlign.center),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
