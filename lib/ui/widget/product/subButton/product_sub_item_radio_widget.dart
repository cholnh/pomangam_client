import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client/domain/product/sub/product_sub.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:provider/provider.dart';

class ProductSubItemRadioWidget extends StatelessWidget {

  final ProductSub sub;
  final ProductSubCategory productSubCategory;

  ProductSubItemRadioWidget({this.sub, this.productSubCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProductModel>(context, listen: false).toggleProductSubIsSelected(
            productSubCategory: productSubCategory,
            subIdx: sub.idx,
            isRadio: true
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 20.0),
        subtitle: sub?.productSubInfo?.description != null
            ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: subTitleFontSize))
            : null,
        leading: Radio(
          groupValue: true,
          value: sub.isSelected,
        ),
        title: Text('${sub.productSubInfo.name}', style: TextStyle(fontSize: titleFontSize)),
        trailing: Text('+ ${sub?.salePrice}원', style: TextStyle(fontSize: titleFontSize)),
      ),
    );
  }
}
