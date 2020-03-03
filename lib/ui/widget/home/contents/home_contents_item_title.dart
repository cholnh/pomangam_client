import 'package:flutter/material.dart';
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
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white
                      ),
                      width: 30.0,
                      height: 30.0,
                      padding: const EdgeInsets.all(0.5),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      )
                  )
              ),
              Padding(padding: EdgeInsets.only(right: 10.0)),
              Text(
                  '${summary.name}',
                  style: TextStyle()
              ),
            ],
          ),
          Text(
              isOpening
                  ? isOrderable
                  ? summary.quantityOrderable <= 5
                  ? '마감임박 ${summary.quantityOrderable}개'
                  : '주문가능 ${summary.quantityOrderable}개'
                  : '주문마감'
                  : '${summary.storeSchedule.pauseDescription}',
              style: TextStyle(
                  color: isOpening || summary.quantityOrderable <= 5 ? Colors.grey : Colors.red,
                  fontSize: 13.0)
          )
        ],
      ),
    );
  }
}
