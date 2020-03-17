import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/views/widgets/cart/cart_app_bar.dart';
import 'package:pomangam_client/views/widgets/product/product_app_bar.dart';
import 'package:pomangam_client/views/widgets/store/store_bottom_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartPage extends StatefulWidget {

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(context),
      bottomNavigationBar: Consumer<CartModel>(
        builder: (_, model, child) {
          int totalPrice = model.totalPrice();
          return totalPrice != 0
          ? StoreBottomBarWidget(
            centerText: '결제하기',
            rightText: '${StringUtils.comma(totalPrice)}원',
            onSelected: _onBottomButtonSelected,
          )
          : Container();
        },
      ),
      body: SmartRefresher(
        physics: BouncingScrollPhysics(),
        enablePullDown: true,
        header: WaterDropMaterialHeader(
          color: primaryColor,
          backgroundColor: backgroundColor,
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 200.0,
                child: Center(child: Text('cart page')),
              ),
            ),
          ],
        ),
      )
    );
  }

  void _onBottomButtonSelected() {
    print('[결제하기 누름]');
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.cart.items.forEach((item) {
      print('${item.product.productInfo.name} ${item.quantity}개');
      item.subs.forEach((sub) {
        print('  - ${sub.productSubInfo.name} ${item.quantity}개');
      });
      print('요구사항: ${item.requirement}');
      print('총액: ${item.totalPrice()}');
      print('------------------------------');
    });
  }

  void _init({bool isBuild = false}) async {

  }

  void _onRefresh() async {
    _init(isBuild: true);
    _refreshController.refreshCompleted();
  }
}