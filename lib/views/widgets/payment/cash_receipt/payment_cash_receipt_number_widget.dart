import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class PaymentCashReceiptNumberWidget extends StatelessWidget {

  final TextEditingController textEditingController;
  final String cashReceiptNumber;
  final bool isIssueCashReceipt;
  final bool isNumberMode;
  final Function onSelected;
  final Function(String) onTextChanged;


  PaymentCashReceiptNumberWidget({
    this.onSelected,
    this.isIssueCashReceipt,
    this.textEditingController,
    this.isNumberMode,
    this.onTextChanged,
    this.cashReceiptNumber
  });

  @override
  Widget build(BuildContext context) {
    if(isIssueCashReceipt) {
      return GestureDetector(
        onTap: onSelected,
        child: Material(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('번호', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  isNumberMode
                  ? Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextFormField(
                        controller: textEditingController,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        autofocus: true,
                        expands: false,
                        keyboardType: TextInputType.number,
                        cursorColor: primaryColor,
                        style: TextStyle(fontSize: 14.0),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: backgroundColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: backgroundColor),
                          ),
                        ),
                        onChanged: onTextChanged,
                      ),
                    ),
                  )
                  : Row(
                    children: <Widget>[
                      Text('$cashReceiptNumber', style: TextStyle(fontSize: 14.0)),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ],
              ),
              Divider(height: 10.0)
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
