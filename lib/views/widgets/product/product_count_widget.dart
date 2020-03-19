import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:pomangam_client/providers/store/store_model.dart';
import 'package:provider/provider.dart';

class ProductCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StoreModel storeModel = Provider.of<StoreModel>(context, listen: false);
    int quantityOrderable = storeModel.summary.quantityOrderable;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '수량',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)
              ),
              Text(
                  ' (최대 $quantityOrderable개)',
                  style: TextStyle(fontSize: 12.0, color: subTextColor)
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 13.0),
            child: Consumer<ProductModel>(
                builder: (_, model, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _onSelected(context, isUp: true),
                        child: Opacity(
                          opacity: quantityOrderable <= model?.quantity ? 0.5 : 1.0,
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              border: Border.all(
                                  width: 1.5,
                                  color: primaryColor
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, color: backgroundColor, size: titleFontSize),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text('${model?.quantity ?? ''}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))
                      ),
                      GestureDetector(
                        onTap: () => _onSelected(context, isUp: false),
                        child: Opacity(
                          opacity: (model?.quantity ?? 0) <= 1 ? 0.5 : 1.0,
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              border: Border.all(
                                  width: 1.5,
                                  color: primaryColor
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.remove, color: backgroundColor, size: titleFontSize),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            ),
          ),
        ),
      ],
    );
  }

  void _onSelected(BuildContext context, {bool isUp}) {
    StoreModel storeModel = Provider.of<StoreModel>(context, listen: false);
    ProductModel productModel = Provider.of<ProductModel>(context, listen: false);
    if(isUp) {
      if(storeModel.summary.quantityOrderable > productModel.quantity) {
        productModel.changeUpQuantity();
      }
    } else {
      productModel.changeDownQuantity();
    }
  }
}
