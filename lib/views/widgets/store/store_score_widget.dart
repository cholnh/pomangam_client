import 'package:flutter/material.dart';
import 'package:pomangam_client/views/widgets/store/store_score_item_widget.dart';

class StoreScoreWidget extends StatelessWidget {

  final double avgStar;
  final int cntLike;
  final int cntComment;

  StoreScoreWidget({this.avgStar, this.cntLike, this.cntComment});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StoreScoreItemWidget(title: '평점', value: '$avgStar'),
            StoreScoreItemWidget(title: '좋아요', value: '$cntLike'),
            StoreScoreItemWidget(title: '리뷰', value: '$cntComment'),
          ],
        )
    );
  }
}
