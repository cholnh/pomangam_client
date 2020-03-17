import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client/domains/product/sub/product_sub.dart';
import 'package:pomangam_client/domains/product/sub/product_sub_type.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:pomangam_client/views/widgets/product/subButton/product_sub_item_checkbox_widget.dart';
import 'package:pomangam_client/views/widgets/product/subButton/product_sub_item_radio_widget.dart';
import 'package:pomangam_client/views/widgets/product/subButton/product_sub_item_readonly_widget.dart';
import 'package:provider/provider.dart';

class ProductSubItemWidget extends StatelessWidget {

  final ProductSubCategory productSubCategory;

  ProductSubItemWidget({this.productSubCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          color: Color.fromRGBO(0, 0, 0, 0.05),
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
          child: Text('${productSubCategory.categoryTitle}', style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold))
        ),
        Column(
          children: _subButtonGroup(context),
        )
      ],
    );
  }

  void _setRadioFirstElement(BuildContext context) {
    if(productSubCategory.productSubType == ProductSubType.RADIO) {
      bool isFirst = true;
      for(ProductSub sub in productSubCategory.productSubs) {
        if(sub.isSelected) {
          isFirst = false;
          break;
        }
      }
      if(isFirst && productSubCategory.productSubs.isNotEmpty) {
        Provider.of<ProductModel>(context, listen: false).toggleProductSubIsSelected(
          productSubCategory: productSubCategory,
          subIdx: productSubCategory.productSubs.first.idx,
          isRadio: true,
          isNotify: false
        );
      }
    }
  }

  List<Widget> _subButtonGroup(BuildContext context) {
    _setRadioFirstElement(context);

    return productSubCategory.productSubs.map((sub) {
      return SizedBox(
        height: 65,
        child: _subButton(context, sub),
      );
    }).toList();
  }

  Widget _subButton(BuildContext context, ProductSub sub) {
    ProductSubType type = productSubCategory.productSubType;

    if(type == ProductSubType.CHECKBOX) {
      return ProductSubItemCheckBoxWidget(sub: sub, productSubCategory: productSubCategory);
    } else if(type == ProductSubType.RADIO) {
      return ProductSubItemRadioWidget(sub: sub, productSubCategory: productSubCategory);
    } else if(type == ProductSubType.NUMBER) {
      return ProductSubItemCheckBoxWidget(sub: sub, productSubCategory: productSubCategory);
      // return ProductSubItemNumberWidget(sub: sub);
    } else if(type == ProductSubType.READONLY) {
      return ProductSubItemReadOnlyWidget(sub: sub);
    } else {
      return Container();
    }
  }
}
