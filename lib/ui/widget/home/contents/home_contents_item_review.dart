import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class HomeContentsItemReview extends StatelessWidget {

  final bool isOpening;
  final bool isOrderable;
  final StoreSummary summary;

  HomeContentsItemReview({this.isOpening, this.isOrderable, this.summary});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isOrderable && isOpening
          ? 1
          : 0.5,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
        child: Text(
            '리뷰 ${summary.cntComment}개 모두 보기',
            style: TextStyle(fontSize: subTitleFontSize, color: Colors.grey)
        ),
      ),
    );
  }
}
