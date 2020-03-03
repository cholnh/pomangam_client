import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/ui/widget/store/store_product_category.dart';
import 'package:transparent_image/transparent_image.dart';

class StoreProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ) ,
      delegate: SliverChildBuilderDelegate((context, index) {
        return new Container(
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
                    image: '${Endpoint.serverDomain}/assets/images/dsites/1/stores/2/products/1/${Random().nextInt(3)+1}.jpg',
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
                    Text('철판볶음밥 세트', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w500)),
                    Text('5,000원', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w500)),
                  ],
                ),
              )
            ],
          ),
        );
      }, childCount: 30)
    );
  }
}

// PmgKeys.storeProduct