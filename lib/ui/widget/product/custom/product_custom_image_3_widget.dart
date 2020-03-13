import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/domain/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:pomangam_client/provider/product/sub/product_sub_category_model.dart';
import 'package:provider/provider.dart';

class ProductCustomImage3Widget extends StatelessWidget {

  final Function(int, int) onSelected;

  final Color borderColor = Colors.white; //Color.fromRGBO(0, 0, 0, 0.8); // // primaryColor
  final double borderWidth = 2.5;
  final Color innerShadowColor = Colors.black26;
  final Color bottomColor = Colors.white; // Color.fromRGBO(0, 0, 0, 0.1)
  final double filterOpacity = 0.3;

  ProductCustomImage3Widget({this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSubCategoryModel>(
      builder: (_, categoryModel, child) {
        int selected = categoryModel.idxSelectedCategory;
        return Consumer<ProductModel>(
          builder: (_, productModel, child) {
            List<ProductSubCategory> subCategories = productModel.product.productSubCategories;
            if(subCategories.length != 3) {
              return Container(
                height: 180,
                child: Center(
                  child: Icon(Icons.error_outline),
                ),
              );
            }

            ProductSubCategory firstCategory = subCategories[0];
            ProductSubCategory secondCategory = subCategories[1];
            ProductSubCategory thirdCategory = subCategories[2];

            return Container(
              height: 180,
              margin: EdgeInsets.only(bottom: 0.0),
              padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 20.0, top: 20.0),
              color: Color.fromRGBO(0, 0, 0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: GestureDetector(
                              onTap: () => _changeCategory(2, secondCategory.idx),
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: secondCategory.selectedProductSub?.productImageMainPath != null ? bottomColor : Colors.white.withOpacity(1-filterOpacity),
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(10.0)
                                  ),
                                  border: Border.all(
                                      color: selected == 2 ? primaryColor : borderColor,
                                      width: borderWidth
                                  ),
                                  image: secondCategory.selectedProductSub?.productImageMainPath != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(filterOpacity), BlendMode.darken),
                                        image: CachedNetworkImageProvider(
                                          '${Endpoint.serverDomain}/${secondCategory.selectedProductSub?.productImageMainPath}',
                                        )
                                      )
                                    : null
                                ),
                                child: Center(
                                  child: secondCategory.selectedProductSub?.productSubInfo?.name == null
                                    ? Text(
                                      '${secondCategory.categoryTitle}',
                                      style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                    )
                                    : Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${secondCategory.selectedProductSub?.productSubInfo?.name}',
                                              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                            (secondCategory.selectedProductSub?.salePrice ?? 0) == 0
                                                ? Container()
                                                : Text(
                                              '+${secondCategory.selectedProductSub?.salePrice}원',
                                              style: TextStyle(fontSize: subTitleFontSize, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ),
                              ),
                            )
                        ),
                        Expanded(
                            child: GestureDetector(
                              onTap: () => _changeCategory(3, thirdCategory.idx),
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: thirdCategory.selectedProductSub?.productImageMainPath != null ? bottomColor : Colors.white.withOpacity(1-filterOpacity),
                                  borderRadius: BorderRadius.only(
                                      topRight: const Radius.circular(10.0)
                                  ),
                                  border: Border.all(
                                      color: selected == 3 ? primaryColor : borderColor,
                                      width: borderWidth
                                  ),
                                  image: thirdCategory.selectedProductSub?.productImageMainPath != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(filterOpacity), BlendMode.darken),
                                        image: CachedNetworkImageProvider(
                                          '${Endpoint.serverDomain}/${thirdCategory.selectedProductSub?.productImageMainPath}',
                                        )
                                      )
                                    : null
                                ),
                                child: thirdCategory.selectedProductSub?.productSubInfo?.name == null
                                  ? Center(
                                      child: Text(
                                        '${thirdCategory.categoryTitle}',
                                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${thirdCategory.selectedProductSub?.productSubInfo?.name}',
                                            style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                          (thirdCategory.selectedProductSub?.salePrice ?? 0) == 0
                                              ? Container()
                                              : Text(
                                            '+${thirdCategory.selectedProductSub?.salePrice}원',
                                            style: TextStyle(fontSize: subTitleFontSize, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )
                              ),
                            )
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _changeCategory(1, firstCategory.idx),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: firstCategory.selectedProductSub?.productImageMainPath != null ? bottomColor : Colors.white.withOpacity(1-filterOpacity),
                          borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0)
                          ),
                          border: Border.all(
                              color: selected == 1 ? primaryColor : borderColor,
                              width: borderWidth
                          ),
                          image: firstCategory.selectedProductSub?.productImageMainPath != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(filterOpacity), BlendMode.darken),
                                image: CachedNetworkImageProvider(
                                  '${Endpoint.serverDomain}/${firstCategory.selectedProductSub?.productImageMainPath}',
                                )
                              )
                            : null
                        ),
                        child: firstCategory.selectedProductSub?.productSubInfo?.name == null
                          ? Center(
                              child: Text(
                                '${firstCategory.categoryTitle}',
                                style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${firstCategory.selectedProductSub?.productSubInfo?.name}',
                                    style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  (firstCategory.selectedProductSub?.salePrice ?? 0) == 0
                                    ? Container()
                                    : Text(
                                      '+${firstCategory.selectedProductSub?.salePrice}원',
                                      style: TextStyle(fontSize: subTitleFontSize, color: Colors.white),
                                    ),
                                ],
                              ),
                            ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  void _changeCategory(int idxSelected, int idxProductSubCategory) {
    this.onSelected(idxSelected, idxProductSubCategory);
  }
}
