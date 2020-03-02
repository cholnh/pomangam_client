import 'package:flutter/material.dart';
import 'package:pomangam_client/ui/widget/store/store_score_item.dart';

class StoreScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StoreScoreItem(title: '평점', value: '3.5'),
            StoreScoreItem(title: '좋아요', value: '357'),
            StoreScoreItem(title: '리뷰', value: '75'),
          ],
        )
    );
  }
}
