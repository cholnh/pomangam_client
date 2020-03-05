import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/domain/product/product_summary.dart';
import 'package:transparent_image/transparent_image.dart';

class StoreProductItem extends StatelessWidget {

  final ProductSummary summary;

  StoreProductItem({this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: backgroundColor)
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.darken,
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: '${Endpoint.serverDomain}/${summary.productImageMainPath}',
                fit: BoxFit.fill,
                fadeInDuration: Duration(milliseconds: 100),
                fadeOutDuration: Duration(milliseconds: 100)
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${summary.name}', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w500)),
                Text('${summary.salePrice}', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w500)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
