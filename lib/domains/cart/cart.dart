import 'package:pomangam_client/domains/cart/item/cart_item.dart';
import 'package:pomangam_client/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:pomangam_client/domains/order/time/order_time.dart';

class Cart {

  DateTime orderDate;

  OrderTime orderTime;

  DeliveryDetailSite detail;

  List<CartItem> items = List();

  int totalPrice() {
    int total = 0;
    items?.forEach((item) {
      total += item?.totalPrice() ?? 0;
    });
    return total;
  }

  void clear() {
    items.clear();
  }
}