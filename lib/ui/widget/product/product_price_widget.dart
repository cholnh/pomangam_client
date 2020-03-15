import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/util/string_utils.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:provider/provider.dart';

class ProductPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
              '가격',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)
          ),
        ),
        Consumer<ProductModel>(
          builder: (_, model, child) {
            int totalPrice = model.totalPrice();
            return Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                  totalPrice == 0 ? '' : '${StringUtils.comma(totalPrice)}원',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)
              ),
            );
          },
        )
      ],
    );
  }
}
