import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/network/constant/endpoint.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/domains/cart/item/cart_item.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:provider/provider.dart';

class StoreSlideFloatingPanelBodyItemWidget extends StatelessWidget {

  final List<CartItem> cartItems;

  StoreSlideFloatingPanelBodyItemWidget({this.cartItems});

  @override
  Widget build(BuildContext context) {
    CartItem first = cartItems.first;
    bool isOrderable = first.isOrderable;

//    int totalQuantity = 0;
//    cartItems.forEach((item) => totalQuantity += item.quantity);
//    bool isOrderable = (first?.quantityOrderable ?? 0) - totalQuantity >= 0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => _navigateToStore(context, first.store.idx),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: isOrderable ? 1.0 : 0.5,
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: '${Endpoint.serverDomain}/${first.store.brandImagePath}',
                                fit: BoxFit.fill,
                                width: 12.0,
                                height: 12.0,
                                placeholder: (context, url) => CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error_outline),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white
                          ),
                          width: 18.0,
                          height: 18.0,
                          padding: const EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                          )
                      ),
                      Text('${first.store.storeInfo.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Text(' (${first?.quantityOrderable ?? 0}개 주문가능)', style: TextStyle(fontSize: 13.0, color: subTextColor))
                    ],
                  ),
                ),
                isOrderable
                ? Container()
                : Text('주문량 초과', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: titleFontSize))
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 5.0)),
          Column(
            children: _itemsWidget(context, isOrderable),
          ),
          Divider(height: 20.0)
        ],
      ),
    );
  }

  List<Widget> _itemsWidget(BuildContext context, bool isOrderable) {
    return this.cartItems.map((cartItem)
    => Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: isOrderable ? 1.0 : 0.3,
                child: Text('${cartItem.product.productInfo.name} ${cartItem.quantity}개', style: TextStyle(fontSize: 14.0))
              ),
              Row(
                children: <Widget>[
                  Opacity(
                    opacity: isOrderable ? 1.0 : 0.3,
                    child: Text('${StringUtils.comma(cartItem.totalPrice())}원', style: TextStyle(fontSize: 13.0))
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0)),
                  GestureDetector(
                    onTap: () => _removeCartItem(context, cartItem),
                    child: Container(
                        color: backgroundColor,
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.clear, size: 18.0, color: isOrderable ? subTextColor : primaryColor)
                    ),
                  ),
                ],
              )
            ],
          ),
          Opacity(
            opacity: isOrderable ? 1.0 : 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _subItems(cartItem),
            ),
          ),
        ],
      ),
    )).toList();
  }

  List<Widget> _subItems(CartItem cartItem) {
    List<Widget> widgets = cartItem.subs.map((sub) {
      return Text(' - ${sub.productSubInfo.name} ${cartItem.quantity}개', style: TextStyle(fontSize: 13.0, color: subTextColor));
    }).toList();
    if(cartItem.requirement != null && cartItem.requirement.isNotEmpty) {
      widgets.add(Text(' - ${cartItem.requirement}', style: TextStyle(fontSize: 13.0, color: subTextColor)));
    }
    return widgets;
  }

  void _removeCartItem(BuildContext context, CartItem cartItem) {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);

    cartModel.removeItem(cartItem);
    cartModel.updateOrderableStore(
      dIdx: deliverySiteModel.userDeliverySite?.idx,
      oIdx: orderTimeModel.userOrderTime?.idx,
      oDate: orderTimeModel.userOrderDate
    );

    Fluttertoast.showToast(
        msg: "삭제되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: titleFontSize
    );
  }

  void _navigateToStore(BuildContext context, int sIdx) {
    Navigator.pushNamed(context, '/stores/$sIdx');
  }
}
