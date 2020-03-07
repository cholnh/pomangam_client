import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:provider/provider.dart';

class StoreCenterButton extends StatelessWidget {

  final int wPadding = 20;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width/2 - wPadding;

    return SliverToBoxAdapter(
      child: Consumer<StoreModel>(
        builder: (_, model, child) {
          bool isCoupon = model.summary.couponType != 0;
          bool isAlreadyIssueCoupon = true;  // Todo: isAlreadyIssueCoupon
          return Column(
            children: <Widget>[
              isCoupon
                  ? SizedBox(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 26,
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
                            style: TextStyle(fontSize: titleFontSize, color: isAlreadyIssueCoupon ? Colors.black38 : primaryColor, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 3.0, left: 3.0),
                            child: Icon(isAlreadyIssueCoupon ? Icons.check : Icons.get_app, size: titleFontSize, color: isAlreadyIssueCoupon ? Colors.black38 : primaryColor)
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
                    height: 27.0,
                    width: w,
                    child: FlatButton(
                      onPressed: () => _onPressedDetailButton(model),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.black12)
                      ),
                      color: backgroundColor,
                      child: Container(
                        child: Text(
                            model.isStoreDescriptionOpened ? '상세정보 접기' : '상세정보',
                            style: TextStyle(fontSize: titleFontSize, color: Colors.black),
                            textAlign: TextAlign.center
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 27.0,
                    width: w,
                    child: FlatButton(
                      onPressed: _onPressedReviewButton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.black12)
                      ),
                      color: backgroundColor,
                      child: Container(
                        child: Text('리뷰보기', style: TextStyle(fontSize: titleFontSize, color: Colors.black), textAlign: TextAlign.center),
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

  void _onPressedDetailButton(StoreModel model) {
    model.toggleIsStoreDescriptionOpened();
  }

  void _onPressedReviewButton() {
    print('review button!!');
  }
}
