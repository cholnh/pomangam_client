import 'package:pomangam_client/domains/product/product.dart';
import 'package:pomangam_client/domains/product/sub/product_sub.dart';
import 'package:pomangam_client/domains/store/store.dart';

class CartItem {

  int idx;

  Store store;

  Product product;

  int quantity;

  List<ProductSub> subs = List();

  String requirement;

  CartItem({
    this.idx, this.store, this.product,
    this.quantity, this.subs, this.requirement
  });

  int totalPrice() {
    int total = 0;
    total += product?.salePrice ?? 0;
    subs?.forEach((sub) {
      total += sub?.salePrice ?? 0;
    });
    return total * quantity;
  }
}