import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_body_widget.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_header_widget.dart';
import 'package:provider/provider.dart';

class StoreSlideFloatingPanelWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]
      ),
      margin: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 53.0),
            child: Column(
              children: <Widget>[
                StoreSlideFloatingPanelHeaderWidget(),
                Flexible(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      StoreSlideFloatingPanelBodyWidget()
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Consumer<CartModel>(
                builder: (_, model, __) {
                  return GestureDetector(
                    child: Opacity(
                      opacity: model.isUpdatedOrderableStore && model.isAllOrderable ? 1.0 : 0.5,
                      child: Container(
                        color: primaryColor,
                        width: MediaQuery.of(context).size.width,
                        height: 53.0,
                        child: Center(
                          child: Text('${StringUtils.comma(model.cart.totalPrice())}원 결제하기', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)),
                        ),
                      ),
                    ),
                    onTap: model.isUpdatedOrderableStore && model.isAllOrderable
                      ? () => print('결제 page 이동')
                      : () {},
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
