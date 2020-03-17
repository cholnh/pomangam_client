import 'package:flutter/cupertino.dart';
import 'package:pomangam_client/domains/cart/cart.dart';
import 'package:pomangam_client/domains/cart/item/cart_item.dart';
import 'package:pomangam_client/domains/order/time/order_time.dart';
import 'package:pomangam_client/domains/product/product.dart';
import 'package:pomangam_client/domains/product/sub/product_sub.dart';
import 'package:pomangam_client/domains/store/store.dart';

class CartModel with ChangeNotifier {

  Cart cart = Cart();

  bool isSameOrderDateTime({
    @required DateTime orderDate,
    @required OrderTime orderTime
  }) {
    bool isSameDate =
      cart.orderDate.year == orderDate.year &&
      cart.orderDate.month == orderDate.month &&
      cart.orderDate.day == orderDate.day;
    bool isSameTime = cart.orderTime.idx == orderTime.idx;
    return isSameDate && isSameTime;
  }

  void addItem({
    @required Store store,
    @required Product product,
    @required int quantity,
    @required List<ProductSub> subs,
    String requirement
  }) {
    this.cart.items.add(CartItem(
        idx: _generateIdx(),
        store: store,
        product: product,
        quantity: quantity,
        subs: subs,
        requirement: requirement
    ));
  }

  void removeItem(CartItem removeItem) {
    this.cart.items.removeWhere((CartItem el) => el.idx == removeItem.idx);
  }

  int _generateIdx() {
    int max = 0;
    this.cart.items?.forEach((item) => max = item.idx > max ? item.idx : max);
    return max + 1;
  }

  int totalPrice() {
    return cart.totalPrice();
  }
}