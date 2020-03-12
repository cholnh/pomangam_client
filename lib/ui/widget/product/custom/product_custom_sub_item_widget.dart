import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/domain/product/sub/category/product_sub_category.dart';

class ProductCustomSubItemWidget extends StatelessWidget {

  final ProductSubCategory productSubCategory;

  ProductCustomSubItemWidget({this.productSubCategory});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = productSubCategory.productSubs.map((sub) {
      return SizedBox(
        height: 65,
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 0.0, right: 15.0),
          leading: CachedNetworkImage(
            imageUrl: '${Endpoint.serverDomain}/${sub.productImageMainPath}',
            width: 90,
            fit: BoxFit.fill,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error_outline),
          ),
          subtitle: sub?.productSubInfo?.description != null
              ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: subTitleFontSize))
              : null,
          title: Text('${sub.productSubInfo.name}', style: TextStyle(fontSize: titleFontSize)),
          trailing: Text('+ ${sub?.salePrice ?? 0}원', style: TextStyle(fontSize: titleFontSize))
        ),
      );
    }).toList();

    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          color: Color.fromRGBO(0, 0, 0, 0.05),
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
          child: Text('${productSubCategory.categoryTitle}', style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold))
        ),
        Column(
          children: widgets
        )
      ],
    );
  }
}
