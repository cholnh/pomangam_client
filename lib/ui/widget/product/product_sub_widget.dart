import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/domain/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:pomangam_client/ui/widget/product/product_sub_item_widget.dart';
import 'package:provider/provider.dart';

class ProductSubWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (_, model, child) {
        if(model.product?.productSubCategories == null || model.product.productSubCategories.isEmpty) {
          return  SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: model.isProductFetching
                  ? CupertinoActivityIndicator()
                  : Text('서브메뉴가 없습니다...', style: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            ),
          );
        }

        List<ProductSubCategory> subCategories = model.product.productSubCategories;
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if(model.idxProductSubCategory == 0) {
              return ProductSubItemWidget(
                  productSubCategory: subCategories[index]
              );
            } else {
              ProductSubCategory subCategory = subCategories[index];
              if(model.idxProductSubCategory == subCategory.idx) {
                return ProductSubItemWidget(
                    productSubCategory: subCategory
                );
              } else {
                return Container();
              }
            }
          }, childCount: subCategories?.length ?? 0)
        );
      }
    );
  }
}