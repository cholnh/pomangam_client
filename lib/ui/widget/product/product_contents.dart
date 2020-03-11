import 'package:flutter/material.dart';
import 'package:pomangam_client/domain/product/product.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_like.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_sub_title.dart';
import 'package:pomangam_client/ui/widget/product/product_count.dart';
import 'package:pomangam_client/ui/widget/product/product_image.dart';
import 'package:pomangam_client/ui/widget/product/product_price.dart';
import 'package:pomangam_client/ui/widget/product/product_review.dart';
import 'package:provider/provider.dart';

class ProductContents extends StatelessWidget {

  final int pIdx;

  ProductContents({this.pIdx});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<ProductModel>(
        builder: (_, model, child) {
          Product product = model.product;
          return Column(
            children: <Widget>[
              ProductImage(
                  pIdx: pIdx
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              HomeContentsItemLike(
                cntLike: product?.cntLike ?? 0,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              HomeContentsItemSubTitle(
                  title: product?.productInfo?.name ?? '',
                  description: product?.productInfo?.description ?? ''
              ),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              ProductReview(
                cntComment: product?.cntReply ?? 0,
                previews: product?.replies ?? List(),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Divider(height: 0.5),
              const Padding(padding: EdgeInsets.only(bottom: 15.0)),
              ProductPrice(),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              ProductCount(),
              const Padding(padding: EdgeInsets.only(bottom: 15.0)),
              Divider(height: 0.5),
            ],
          );
        }
      ),
    );
  }
}
