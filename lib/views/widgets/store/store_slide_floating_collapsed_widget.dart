import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:provider/provider.dart';

class StoreSlideFloatingCollapsedWidget extends StatelessWidget {

  final Function onSelected;

  StoreSlideFloatingCollapsedWidget({this.onSelected});

  @override
  Widget build(BuildContext context) {
    CartModel cartModel = Provider.of<CartModel>(context);
    int cartCount = cartModel.cart?.items?.length ?? 0;
    int totalPrice = cartModel.cart.totalPrice();
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
                    Container(
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
                          '$cartCount',
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 12.0)
                      ),
                    ),
                    Text(
                        '카트',
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
