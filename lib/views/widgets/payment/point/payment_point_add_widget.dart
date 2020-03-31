import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';

class PaymentPointAddWidget extends StatelessWidget {

  final TextEditingController textEditingController;
  final int userPoint;
  final Function onSelected;

  PaymentPointAddWidget({this.textEditingController, this.userPoint, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 50.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextFormField(
                controller: textEditingController,
                textAlign: TextAlign.left,
                maxLines: 1,
                autofocus: true,
                expands: false,
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                cursorColor: primaryColor,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: primaryColor),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(userPoint.toString().length*2),
                ],
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (val) {
                  int usingPoint = int.tryParse(val) ?? 0;
                  if(usingPoint > userPoint) {
                    usingPoint = userPoint;
                  }
                  if(usingPoint <= 0) {
                    usingPoint = 0;
                  }
                  textEditingController.text = usingPoint.toString();
                },
                decoration: InputDecoration(
                  labelText: '포인트 사용',
                  helperText: '1원 이상, ${StringUtils.comma(userPoint)}원 이하, 1원 단위로 사용 가능',
                  helperStyle: TextStyle(fontSize: 11.0, color: subTextColor),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onSelected,
            child: Container(
              width: 80.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(const Radius.circular(6.0))
              ),
              child: Center(
                  child: Text('사용', style: TextStyle(color: backgroundColor, fontSize: 14.0))
              ),
            ),
          )
        ],
      ),
    );
  }
}
