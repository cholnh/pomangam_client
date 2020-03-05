import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/provider/product/product_summary_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/ui/widget/home/home_bottom_loader.dart';
import 'package:pomangam_client/ui/widget/store/store_product_category.dart';
import 'package:pomangam_client/ui/widget/store/store_product_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class StoreProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSummaryModel>(
      builder: (_, model, child) {
        if(model.productSummaries.length == 0) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('주문가능한 메뉴가 없습니다...', style: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            ),
          );
        }
        return SliverGrid(
          key: PmgKeys.storeProduct,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return index >= model.productSummaries.length
              ? HomeBottomLoader()
              : StoreProductItem(summary: model.productSummaries[index]);
          },
          childCount: model.hasReachedMax
            ? model.productSummaries.length
            : model.productSummaries.length + 1)
        );
      },
    );
  }
}