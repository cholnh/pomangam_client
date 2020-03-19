import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/cart/item/cart_item.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_body_item_widget.dart';
import 'package:provider/provider.dart';

class StoreSlideFloatingPanelBodyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (_, model, child) {
        List<CartItem> items = model.cart.items;
        if(items.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(child: Text('장바구니가 비었습니다.', style: TextStyle(color: subTextColor, fontSize: 14))),
          );
        }
        if(!model.isUpdatedOrderableStore) {
          return SliverToBoxAdapter(
            child: Center(child: CupertinoActivityIndicator())
          );
        }

        List<int> idxesStore = model.idxesStoreInCartItem().toList();
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            int idxStore = idxesStore[index];
            List<CartItem> cartItems = model.cart.items.where((item) => item.store.idx == idxStore).toList();
            return StoreSlideFloatingPanelBodyItemWidget(
              cartItems: cartItems,
            );
          } , childCount: idxesStore.length)
        );
      }
    );
  }
}
