import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class HomeContentsItemLike extends StatelessWidget {

  final double opacity;
  final int cntLike;
  final int couponType;
  final int couponValue;

  HomeContentsItemLike({this.opacity = 1.0, this.cntLike, this.couponType = 0, this.couponValue = 0});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
            child: Text(
                '좋아요 $cntLike개',
                style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600)
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: couponType == 0
                  ? Container()
                  : Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.0)
                ),
                child: Text('$couponValue원 쿠폰', style: TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.w600)),
              )
          ),
        ],
      ),
    );
  }
}
