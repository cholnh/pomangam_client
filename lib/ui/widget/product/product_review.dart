import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/product/review/product_reply.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class ProductReview extends StatelessWidget {

  final double opacity;
  final int cntComment;
  final List<ProductReply> previews;

  ProductReview({this.opacity = 1.0, this.cntComment, this.previews});

  @override
  Widget build(BuildContext context) {

    List<Widget> previewWidgets = previews?.map((preview) =>_buildWidget(preview))?.toList();

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
            Column(
              children: previewWidgets,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWidget(ProductReply preview) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Row(
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
                  TextSpan(text: '${preview.nickname} ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${preview.contents}'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(
              preview.isLike ? Icons.favorite : Icons.favorite_border,
              color: Colors.grey, size: 12.0
            ),
          )
        ],
      ),
    );
  }
}
