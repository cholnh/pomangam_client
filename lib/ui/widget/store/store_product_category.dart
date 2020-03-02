import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class StoreProductCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(5, (int index) {
          return Container(
            child: Card(
              semanticContainer: true,
              color: backgroundColor,
              child: Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: Text('${index==0?'전체':index==1?'메인메뉴':index==2?'서브메뉴':index==3?'토핑':'음료'}')
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          );
        })
      ),
    );
  }
}
