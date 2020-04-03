import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:provider/provider.dart';
class SignInPhoneNumberInputWidget extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSelected;
  final bool isView;

  SignInPhoneNumberInputWidget({this.controller, this.focusNode, this.onSelected, this.isView});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isView ? 1.0 : 0.0,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            autocorrect: false,
            enableSuggestions: false,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            style: TextStyle(fontWeight: FontWeight.bold),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              NumberTextInputFormatter(),
              LengthLimitingTextInputFormatter(13)
            ],
            decoration: InputDecoration(
              labelText: '휴대폰 번호',
              alignLabelWithHint: true,
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 20.0)),
          Consumer<SignInModel>(
            builder: (_, model, __) {
              bool isLock = model.signInPhoneNumberLock;
              return GestureDetector(
                onTap: () => isLock || !isView ? {} : onSelected(),
                child: SizedBox(
                  height: 50.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    child: Center(
                      child: isLock
                        ? CupertinoActivityIndicator()
                        : Text('인증문자 받기', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 17.0)),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ' ');
      if (newValue.selection.end >= 3)
        selectionIndex++;
    }
    if (newTextLength >= 8) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 7) + ' ');
      if (newValue.selection.end >= 7)
        selectionIndex++;
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}