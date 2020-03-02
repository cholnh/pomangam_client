import 'dart:math';

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
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: '${Endpoint.serverDomain}/assets/images/dsites/1/stores/2/products/1/${Random().nextInt(3)+1}.jpg',
              fit: BoxFit.fill,
              fadeInDuration: Duration(milliseconds: 100),
              fadeOutDuration: Duration(milliseconds: 100)
          ),
        );
      }, childCount: 30)
    );
  }
}

// PmgKeys.storeProduct