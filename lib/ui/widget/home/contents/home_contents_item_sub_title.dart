import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
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
        padding: EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
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
              TextSpan(text: '${summary.name} ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '${summary.description}'),
            ],
          ),
        )
      ),
    );
  }
}
