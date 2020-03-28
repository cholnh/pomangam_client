import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/network/constant/endpoint.dart';
import 'package:pomangam_client/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client/domains/product/sub/product_sub.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:pomangam_client/providers/product/sub/product_sub_category_model.dart';
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
            List<ProductSubCategory> subCategories = productModel.product?.productSubCategories;
            if(subCategories == null) {
              return Container(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
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

            ProductSub firstSub = firstCategory.selectedProductSub.isNotEmpty ? firstCategory.selectedProductSub?.first : null;
            ProductSub secondSub = secondCategory.selectedProductSub.isNotEmpty ? secondCategory.selectedProductSub?.first : null;
            ProductSub thirdSub = thirdCategory.selectedProductSub.isNotEmpty ? thirdCategory.selectedProductSub?.first : null;

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
                                  color: secondSub?.productImageMainPath != null
                                      ? bottomColor
                                      : Colors.white.withOpacity(1-filterOpacity),
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(10.0)
                                  ),
                                  border: Border.all(
                                      color: selected == 2 ? primaryColor : borderColor,
                                      width: borderWidth
                                  ),
                                  image: secondSub?.productImageMainPath != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(filterOpacity), BlendMode.darken),
                                        image: CachedNetworkImageProvider(
                                          '${Endpoint.serverDomain}/${secondSub.productImageMainPath}',
                                        )
                                      )
                                    : null
                                ),
                                child: Center(
                                  child: secondSub?.productSubInfo?.name == null
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
                                              '${secondSub?.productSubInfo?.name}',
                                              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                            (secondSub?.salePrice ?? 0) == 0
                                                ? Container()
                                                : Text(
                                              '+${secondSub?.salePrice}원',
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
                                  color: thirdSub?.productImageMainPath != null
                                    ? bottomColor
                                    : Colors.white.withOpacity(1-filterOpacity),
                                  borderRadius: BorderRadius.only(
                                      topRight: const Radius.circular(10.0)
                                  ),
                                  border: Border.all(
                                      color: selected == 3 ? primaryColor : borderColor,
                                      width: borderWidth
                                  ),
                                  image: thirdSub?.productImageMainPath != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(filterOpacity), BlendMode.darken),
                                        image: CachedNetworkImageProvider(
                                          '${Endpoint.serverDomain}/${thirdSub?.productImageMainPath}',
                                        )
                                      )
                                    : null
                                ),
                                child: thirdSub?.productSubInfo?.name == null
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
                                            '${thirdSub?.productSubInfo?.name}',
                                            style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                          (thirdSub?.salePrice ?? 0) == 0
                                              ? Container()
                                              : Text(
                                            '+${thirdSub?.salePrice}원',
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
                          color: firstSub?.productImageMainPath != null
                            ? bottomColor
                            : Colors.white.withOpacity(1-filterOpacity),
                          borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0)
                          ),
                          border: Border.all(
                              color: selected == 1 ? primaryColor : borderColor,
                              width: borderWidth
                          ),
                          image: firstSub?.productImageMainPath != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(filterOpacity), BlendMode.darken),
                                image: CachedNetworkImageProvider(
                                  '${Endpoint.serverDomain}/${firstSub?.productImageMainPath}',
                                )
                              )
                            : null
                        ),
                        child: firstSub?.productSubInfo?.name == null
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
                                    '${firstSub?.productSubInfo?.name}',
                                    style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  (firstSub?.salePrice ?? 0) == 0
                                    ? Container()
                                    : Text(
                                      '+${firstSub?.salePrice}원',
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
