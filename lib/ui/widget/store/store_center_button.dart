import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:provider/provider.dart';

class StoreCenterButton extends StatelessWidget {

  final int wPadding = 40;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width/2 - wPadding;


    return SliverToBoxAdapter(
      child: Consumer<StoreModel>(
        builder: (_, model, child) {
          bool isCoupon = model.summary.couponType != 0;
          bool isAlreadyIssueCoupon = false;  // Todo: isAlreadyIssueCoupon
          return Column(
            children: <Widget>[
              isCoupon
                  ? SizedBox(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 52,
                child: FlatButton(
                  onPressed: _onPressedCouponButton,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: isAlreadyIssueCoupon ? Colors.white : primaryColor)
                  ),
                  color: isAlreadyIssueCoupon ? Color.fromRGBO(0, 0, 0, 0.1) : backgroundColor,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            isAlreadyIssueCoupon
                                ? '${model.summary.couponValue}원 쿠폰 받기 완료'
                                : '${model.summary.couponValue}원 쿠폰 받기',
                            style: TextStyle(fontSize: 15.0, color: isAlreadyIssueCoupon ? Colors.black38 : primaryColor, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 3.0, left: 3.0),
                            child: Icon(isAlreadyIssueCoupon ? Icons.check : Icons.get_app, size: 15.0, color: isAlreadyIssueCoupon ? Colors.black38 : primaryColor)
                        )
                      ],
                    ),
                  ),
                ),
              )
                  : Container(),
              isCoupon
                  ? Padding(padding: EdgeInsets.only(bottom: 15.0))
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 32.0,
                    width: w,
                    child: FlatButton(
                      onPressed: _onPressedDetailButton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.black12)
                      ),
                      color: backgroundColor,
                      child: Container(
                        child: Text('상세정보', style: TextStyle(fontSize: 15.0, color: Colors.black), textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                    width: w,
                    child: FlatButton(
                      onPressed: _onPressedReviewButton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.black12)
                      ),
                      color: backgroundColor,
                      child: Container(
                        child: Text('리뷰보기', style: TextStyle(fontSize: 15.0, color: Colors.black), textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  void _onPressedCouponButton() {
    print('coupon button!!');
  }

  void _onPressedDetailButton() {
    print('detail button!!');
  }

  void _onPressedReviewButton() {
    print('review button!!');
  }
}
