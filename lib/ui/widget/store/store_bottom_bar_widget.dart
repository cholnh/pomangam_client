import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/product/sub/product_sub.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:provider/provider.dart';

class StoreBottomBarWidget extends StatelessWidget {

  final int centerCount;
  final String centerText;
  final String rightText;

  StoreBottomBarWidget({this.centerCount, this.centerText = '', this.rightText = ''});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: GestureDetector(
        onTap: () => _onSelected(context),
        child: Container(
          color: primaryColor,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    centerCount != null
                      ? Container(
                          margin: EdgeInsets.only(right: 4.0),
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(
                              width: 1.5,
                              color: backgroundColor
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                              '$centerCount',
                              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 12.0)
                          ),
                        )
                      : Container(),
                    Text(
                        '$centerText',
                        style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)
                    ),
                  ],
                )
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                      '$rightText',
                      style: TextStyle(color: backgroundColor, fontSize: 14.0)
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelected(BuildContext context) {
    List<ProductSub> selectedSubs = List();
    Provider.of<ProductModel>(context, listen: false)
        .product.productSubCategories.forEach((subCategory) => selectedSubs.addAll(subCategory.selectedProductSub));

    // print
    selectedSubs.forEach((sub) => print('${sub.productSubInfo.name}'));
  }
}
