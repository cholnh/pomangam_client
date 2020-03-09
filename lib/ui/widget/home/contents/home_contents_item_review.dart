import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class HomeContentsItemReview extends StatelessWidget {

  final double opacity;
  final int cntComment;

  HomeContentsItemReview({this.opacity = 1.0, this.cntComment});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
        child: Text(
            '리뷰 $cntComment개 모두 보기',
            style: TextStyle(fontSize: subTitleFontSize, color: Colors.grey)
        ),
      ),
    );
  }
}
