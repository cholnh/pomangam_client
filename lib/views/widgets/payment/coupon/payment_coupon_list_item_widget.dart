import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class PaymentCouponListItemWidget extends StatelessWidget {

  final String title;
  final String subtitle;
  final String date;
  final bool isValid;
  final bool isUsed;
  final bool isNew;
  final bool isUsing;
  final Function onCouponSelected;

  PaymentCouponListItemWidget({
    this.title,
    this.subtitle,
    this.date,
    this.isValid,
    this.isUsed,
    this.isNew = false,
    this.isUsing = false,
    this.onCouponSelected
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
      child: GestureDetector(
        onTap: onCouponSelected,
        child: Material(
          elevation: !isUsed && isValid ? 8.0 : 2.0,
          borderRadius: BorderRadius.circular(18.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 30.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '$title',
                                    style: TextStyle(
                                        color: !isUsed && isValid ? primaryColor : subTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  isNew ? Padding(padding: const EdgeInsets.only(right: 6.0)) : Container(),
                                  isNew ? Text('new', style: TextStyle(color: primaryColor, fontSize: 11.0, fontWeight: FontWeight.bold)) : Container()
                                ],
                              ),
                              Padding(padding: const EdgeInsets.only(bottom: 5.0)),
                              Text(
                                '$subtitle',
                                style: TextStyle(color: subTextColor, fontSize: 12.0),
                              ),
                              Text(
                                '$date',
                                style: TextStyle(color: subTextColor, fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(thickness: 1.0),
                      Container(
                        width: 70.0,
                        child: Center(
                          child: Text(
                            isUsed ? '사용완료' : isValid ? isUsing ? '사용취소' : '사용하기' : '기간만료',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: !isUsed && isValid ? primaryColor : subTextColor,
                                fontWeight: !isUsed && isValid ? FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 5.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: !isUsed && isValid ? primaryColor : subTextColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
