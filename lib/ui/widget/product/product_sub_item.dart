import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/product/sub/category/product_sub_category.dart';

class ProductSubItem extends StatelessWidget {

  final ProductSubCategory productSubCategory;

  ProductSubItem({this.productSubCategory});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 10.0),
          subtitle: Text('${productSubCategory.productSubType}', style: TextStyle(fontSize: subTitleFontSize)),
          leading: Radio(
            value: false,
          ),
          title: Text('${productSubCategory.categoryTitle}', style: TextStyle(fontSize: titleFontSize)),
//          trailing: Text('+ ${productSub.salePrice}원', style: TextStyle(fontSize: titleFontSize)),
        ),
      ),
    );
  }
}
