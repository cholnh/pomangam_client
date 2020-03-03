import 'package:flutter/material.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class HomeContentsItemSubTitle extends StatelessWidget {

  final bool isOpening;
  final bool isOrderable;
  final StoreSummary summary;

  HomeContentsItemSubTitle({this.isOpening, this.isOrderable, this.summary});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isOrderable && isOpening
          ? 1
          : 0.5,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 3.0 + HomeContentsItem.contentsPaddingValue, right: 3.0 + HomeContentsItem.contentsPaddingValue),
        child: Text(
            '${_removeAllHtmlTags(summary.description)}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            softWrap: true,

            style: TextStyle(color: Colors.grey, fontSize: 13)),
      ),
    );
  }

  _removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }
}
