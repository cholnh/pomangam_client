import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/coupon/coupon_model.dart';
import 'package:pomangam_client/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:provider/provider.dart';

class PaymentCouponAddWidget extends StatelessWidget {

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final bool isSignIn;

  PaymentCouponAddWidget({this.isSignIn = false});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextFormField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  autofocus: false,
                  expands: false,
                  keyboardType: TextInputType.text,
                  cursorColor: primaryColor,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: primaryColor),
                  inputFormatters: [
                    CouponFormatter(),
                    LengthLimitingTextInputFormatter(14),
                  ],
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: '쿠폰코드 등록',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onCouponIssueSelected(context),
              child: Container(
                width: 80.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(const Radius.circular(6.0))
                ),
                child: Center(
                    child: Text('등록', style: TextStyle(color: backgroundColor, fontSize: 14.0))
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onCouponIssueSelected(BuildContext context) async {
    bool isValidCode;
    CouponModel couponModel = Provider.of<CouponModel>(context, listen: false);
    String code = _textEditingController.text;

    if(!StringUtils.isValidCouponCode(code)) {
      _dialog(context, '쿠폰번호를 확인해주세요.');
      return;
    }

    if(isSignIn) {
      isValidCode = await couponModel.saveByCode(code: code);
    } else {
      isValidCode = await couponModel.fetchOne(code: code);
    }

    if(!isValidCode) {
      _dialog(context, '이미 등록되었거나 존재하지 않는 쿠폰입니다.');
      return;
    } else {
      _textEditingController.clear();
      _focusNode.unfocus();
      Fluttertoast.showToast(
          msg: "쿠폰 등록 완료",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: titleFontSize
      );
    }
  }

  void _dialog(BuildContext context, String text) {
    DialogUtils.dialog(
        context,
        '$text',
        onPressed: (dialogContext) {
          Navigator.pop(dialogContext);
        }
    );
  }
}


class CouponFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    var text = _addSeperators(newValue.text, '-');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('-', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 3) {
        newString += seperator;
      }
      if (i == 7) {
        newString += seperator;
      }
    }
    return newString?.toUpperCase();
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}