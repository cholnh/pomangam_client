import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class HomeContentsItemLike extends StatelessWidget {

  final bool isOpening;
  final bool isOrderable;
  final StoreSummary summary;

  HomeContentsItemLike({this.isOpening, this.isOrderable, this.summary});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isOrderable && isOpening
          ? 1
          : 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    '${summary.cntLike} likes',
                    style: TextStyle()
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: summary.couponType == 0
                  ? Container()
                  : Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.0)
                ),
                child: Text('${summary.couponValue}원 쿠폰', style: TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.w600)),
              )
          ),
        ],
      ),
    );
  }
}
