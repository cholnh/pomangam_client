import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item.dart';

class HomeContentsItemTitle extends StatelessWidget {

  final bool isOpening;
  final bool isOrderable;
  final StoreSummary summary;

  HomeContentsItemTitle({this.isOpening, this.isOrderable, this.summary});

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
                  tag: 'storeImageHero${summary.idx}',
                  child: Container(
                      child: CircleAvatar(
                          child: Image.network(
                            '${Endpoint.serverDomain}${summary.brandImagePath}',
                            width: 24,
                            height: 24,
                            fit: BoxFit.fill,
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
                      '${summary.name}',
                      style: TextStyle(fontSize: subTitleFontSize, fontWeight: FontWeight.bold)
                  ),
                  Padding(padding: EdgeInsets.only(top: 1.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _star(summary.avgStar),
                  ),
                ],
              ),
            ],
          ),
          Text(
            isOpening
              ? summary.quantityOrderable > 0 && isOrderable
                ? summary.quantityOrderable <= 5
                  ? '마감임박 ${summary.quantityOrderable}개'
                  : '주문가능 ${summary.quantityOrderable}개'
                : '주문마감'
              : '${summary.storeSchedule.pauseDescription}',
            style: TextStyle(
              color: summary.quantityOrderable <= 5 ? primaryColor : Colors.grey,
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
