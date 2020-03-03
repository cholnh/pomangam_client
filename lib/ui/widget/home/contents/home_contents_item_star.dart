import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class HomeContentsItemStar extends StatelessWidget {

  final bool isOpening;
  final bool isOrderable;
  final StoreSummary summary;

  HomeContentsItemStar({this.isOpening, this.isOrderable, this.summary});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isOrderable && isOpening
          ? 1
          : 0.5,
      child: Padding(
        padding: const EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.star, color: primaryColor, size: 18),
            Text(
                '${summary.avgStar} ・ 리뷰 ${summary.cntComment}',
                style: TextStyle()
            ),
          ],
        ),
      ),
    );
  }
}
