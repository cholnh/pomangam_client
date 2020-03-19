import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:provider/provider.dart';

class ProductSlideFloatingCollapsedWidget extends StatelessWidget {

  final Function onSelected;

  ProductSlideFloatingCollapsedWidget({this.onSelected});

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = Provider.of<ProductModel>(context);
    int totalPrice = productModel.totalPrice();
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        ),
        margin: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0.0),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        '카트에 추가',
                        style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)
                    ),
                  ],
                )
            ),
            totalPrice != 0
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                      '${StringUtils.comma(totalPrice)}원',
                      style: TextStyle(color: backgroundColor, fontSize: 14.0)
                  ),
                )
            )
            : Container(),
          ],
        ),
      ),
    );
  }
}
