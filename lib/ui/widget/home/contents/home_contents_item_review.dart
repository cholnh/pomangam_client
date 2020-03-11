import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/product/review/product_reply.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                '리뷰 $cntComment개 모두 보기',
                style: TextStyle(fontSize: subTitleFontSize, color: Colors.grey)
            ),
            const Padding(padding: EdgeInsets.only(bottom: 7.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: titleFontSize,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'momstouch ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.favorite_border, color: Colors.grey, size: 12.0),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
