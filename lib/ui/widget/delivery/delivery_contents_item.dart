import 'package:flutter/material.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/domain/store/store_summary_entity.dart';
import 'package:transparent_image/transparent_image.dart';

class DeliveryContentsItem extends StatelessWidget {
  static const double paddingValue = 25.0;
  final StoreSummaryEntity store;

  DeliveryContentsItem({this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: paddingValue, right: paddingValue),
      child: Column(
        children: <Widget>[
          // 이미지
          Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.3)
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: '${Endpoint.serverDomain}${store.imgpath}',
                  width: MediaQuery.of(context).size.width - paddingValue,
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                  color: const Color.fromRGBO(0xff, 0, 0, 0.9),
                  child: const Text(
                      '3,000원 할인',
                      style: TextStyle(color: Colors.white)
                  ),
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 13.0)),

          // 타이틀
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${store.name}',
                style: TextStyle(fontWeight: FontWeight.bold)
              ),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange, width: 2)
                ),
                child: const Text('2000원 쿠폰', style: TextStyle(color: Colors.deepOrange, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5.0)),

          // 별점, 리뷰개수
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.star, color: Colors.deepOrange, size: 17),
              Text(
                  '4.8 ・ 리뷰 ${store.cntComment}',
                  style: TextStyle()
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5.0)),

          // 서브 타이틀

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
            child: Text(
                '${store.description}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                softWrap: true,

                style: TextStyle(color: Colors.grey, fontSize: 13)),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 26.0)),
        ],
      ),
    );
  }
}
