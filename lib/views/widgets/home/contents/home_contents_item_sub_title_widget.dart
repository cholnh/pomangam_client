import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/views/widgets/home/contents/home_contents_item_widget.dart';

class HomeContentsItemSubTitleWidget extends StatelessWidget {

  final double opacity;
  final String title;
  final String description;
  final String subDescription;
  final int maxLines;

  HomeContentsItemSubTitleWidget({this.opacity = 1.0, this.title, this.description, this.subDescription, this.maxLines = 2});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: HomeContentsItemWidget.contentsPaddingValue, right: HomeContentsItemWidget.contentsPaddingValue),
        child: RichText(
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          softWrap: true,
          text: TextSpan(
            style: TextStyle(
              fontSize: titleFontSize,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: '$title ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: description),
              TextSpan(text: subDescription)
            ],
          ),
        )
      ),
    );
  }
}
