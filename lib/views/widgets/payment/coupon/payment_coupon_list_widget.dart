import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/domains/coupon/coupon.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/coupon/coupon_model.dart';
import 'package:pomangam_client/views/widgets/payment/coupon/payment_coupon_list_item_widget.dart';
import 'package:provider/provider.dart';

class PaymentCouponListWidget extends StatelessWidget {

  final bool isSignIn;

  PaymentCouponListWidget({this.isSignIn = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (_, cartModel, __) {
        List<Coupon> usingCoupons = cartModel.getUsingCoupons();

        return Consumer<CouponModel>(
            builder: (_, couponModel, __) {
              List<Coupon> coupons = couponModel.getCoupon();

              if(couponModel.isCouponsFetching) {
                return SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: CupertinoActivityIndicator()
                        )
                    )
                );
              }
              if(coupons.isEmpty) {
                return SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: Text('사용가능한 쿠폰이 없습니다.', style: TextStyle(fontSize: 12.0, color: subTextColor))
                        )
                    )
                );
              }
              return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    Coupon coupon = coupons[index];
                    bool isUsing = _isUsing(usingCoupons, coupon);

                    return PaymentCouponListItemWidget(
                      title: '${StringUtils.comma(coupon.discountCost)}원 할인',
                      subtitle: coupon.title,
                      date: _date(coupon.endDate),
                      isUsed: coupon.isUsed,
                      isValid: coupon.isValid(),
                      isNew: couponModel.searchCoupon?.idx == coupon.idx,
                      isUsing: isUsing,
                      onCouponSelected: () => _onCouponSelected(context, coupon, isUsing),
                    );
                  }, childCount: coupons.length)
              );
            }
        );
      }
    );
  }

  bool _isUsing(List<Coupon> usingCoupons, Coupon targetCoupon) {
    for (Coupon usingCoupon in usingCoupons) {
      if(usingCoupon.idx == targetCoupon.idx) {
        return true;
      }
    }
    return false;
  }

  void _onCouponSelected(BuildContext context, Coupon coupon, bool isUsing) {
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);

    if(isUsing) {
      cartModel.cancelCoupon(coupon, notify: true);

      // toast 메시지
      Fluttertoast.showToast(
          msg: "취소완료",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: titleFontSize
      );
      return;
    }
    if(coupon.isValid()) {

      if(isSignIn) {
        cartModel.addCoupon(coupon);
      } else {
        cartModel.usingCouponCode = coupon;
      }

      Navigator.pop(context);

      // toast 메시지
      Fluttertoast.showToast(
          msg: "적용완료",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: titleFontSize
      );
    }
  }

  String _date(DateTime dt) {
    if(dt == null) {
      return '기한 무제한';
    }
    return DateFormat('~ yyyy.MM.dd 까지').format(dt);
  }
}
