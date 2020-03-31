import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class PaymentCouponAddWidget extends StatelessWidget {

  final TextEditingController _textEditingController = TextEditingController();

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
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  autofocus: false,
                  expands: false,
                  keyboardType: TextInputType.text,
                  cursorColor: primaryColor,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: primaryColor),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(14),
                    UpperCaseTextFormatter()
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
              onTap: _onCouponIssueSelected,
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

  void _onCouponIssueSelected() {
    print('${_textEditingController.text} 등록');
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}