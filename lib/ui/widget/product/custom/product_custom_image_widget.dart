import 'package:flutter/material.dart';
import 'package:pomangam_client/domain/product/product_type.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:pomangam_client/ui/widget/product/custom/product_custom_image_3_widget.dart';
import 'package:provider/provider.dart';

class ProductCustomImageWidget extends StatelessWidget {

  final ProductType productType;
  final Function(int, int) onSelected;

  ProductCustomImageWidget({this.productType, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (_, model, child) {
        return ProductCustomImage3Widget(
          onSelected: onSelected,
        );
      },
    );
  }
}