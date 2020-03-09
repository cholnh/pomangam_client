import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class HomeContentsItemTitle extends StatelessWidget {

  final String heroTag;
  final String brandImagePath;
  final String title;
  final String subTitle;
  final Color subTitleColor;
  final double avgStar;

  HomeContentsItemTitle({this.heroTag, this.brandImagePath, this.title,
      this.subTitle, this.subTitleColor, this.avgStar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Hero(
                  tag: heroTag,
                  child: Container(
                      child: CircleAvatar(
                          child: CachedNetworkImage(
                            imageUrl: brandImagePath,
                            fit: BoxFit.fill,
                            width: 24.0,
                            height: 24.0,
                            placeholder: (context, url) => CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white
                      ),
                      width: 34.0,
                      height: 34.0,
                      padding: const EdgeInsets.all(0.5),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      )
                  )
              ),
              Padding(padding: EdgeInsets.only(right: 10.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: subTitleFontSize, fontWeight: FontWeight.bold)
                  ),
                  Padding(padding: EdgeInsets.only(top: 1.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _star(avgStar),
                  ),
                ],
              ),
            ],
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: subTitleColor,
              fontSize: subTitleFontSize
            )
          )
        ],
      ),
    );
  }

  List<Widget> _star(double avgStar) {
    int q = avgStar <= 0 ? 0 : avgStar ~/ 1;      // 몫
    double r = avgStar <= 0 ? 0 : avgStar % q;    // 나머지

    q = q > 5 ? 5 : q;
    int cnt = 0;
    List<Widget> widgets = List();
    for(int i=0; i<q; i++) {
      widgets.add(const Icon(Icons.star, color: primaryColor, size: subTitleFontSize));
      cnt++;
    }
    if(r != 0.0) {
      widgets.add(const Icon(Icons.star_half, color: primaryColor, size: subTitleFontSize));
      cnt++;
    }
    for(int i=0; i<5-cnt; i++) {
      widgets.add(const Icon(Icons.star_border, color: primaryColor, size: subTitleFontSize));
    }
    return widgets;
  }
}
