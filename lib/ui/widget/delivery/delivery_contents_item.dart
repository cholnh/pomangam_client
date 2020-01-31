import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class DeliveryContentsItem extends StatelessWidget {
  static const double paddingValue = 25.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: paddingValue, right: paddingValue),
      child: Column(
        children: <Widget>[
          // 이미지
          Stack(
            children: <Widget>[
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'https://www.hakonenavi.jp/international/en/wp-content/uploads/sites/2/2019/01/img326o.jpg',
                width: MediaQuery.of(context).size.width - paddingValue,
                height: 200,
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
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
          const Align(
            alignment: Alignment.centerLeft,
            child: const Text(
                '쇼쿠지',
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5.0)),

          // 별점, 리뷰개수
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.star, color: Colors.deepOrange, size: 17),
              const Text(
                  '4.8 ・ 리뷰 1,074',
                  style: TextStyle()
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5.0)),

          // 서브 타이틀
          Text(
              '맛있는 닭강정을 드리기위해 매일 깨끗한 기름으로 교체하고 맛과 바삭함을 살려주는 특제 파우더와 소스로 특별한 맛을 제공합니다.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(color: Colors.grey, fontSize: 13)),
          const Padding(padding: EdgeInsets.only(bottom: 20.0)),
        ],
      ),
    );
  }
}
