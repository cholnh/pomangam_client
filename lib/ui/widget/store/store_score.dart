import 'package:flutter/material.dart';
import 'package:pomangam_client/ui/widget/store/store_score_item.dart';

class StoreScore extends StatelessWidget {

  final double avgStar;
  final int cntLike;
  final int cntComment;

  StoreScore({this.avgStar, this.cntLike, this.cntComment});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StoreScoreItem(title: '평점', value: '$avgStar'),
            StoreScoreItem(title: '좋아요', value: '$cntLike'),
            StoreScoreItem(title: '리뷰', value: '$cntComment'),
          ],
        )
    );
  }
}
