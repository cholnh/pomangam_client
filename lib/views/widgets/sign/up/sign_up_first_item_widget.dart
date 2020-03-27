import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/domains/user/enum/sign_view_state.dart';
import 'package:pomangam_client/providers/sign/sign_up_model.dart';

class SignUpFirstItemWidget extends StatelessWidget {
  final Animation animation;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function onComplete;
  final SignUpModel model;

  SignUpFirstItemWidget({this.animation, this.controller, this.focusNode,
      this.onChanged, this.onComplete, this.model});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: TextFormField(
            controller: controller,
            autofocus: true,
            focusNode: focusNode,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontWeight: FontWeight.bold, locale: Locale('ko')),
            decoration: InputDecoration(
              labelText: '이름',
              alignLabelWithHint: true,
              suffixIcon: IconButton(
                padding: EdgeInsets.only(top: 15.0),
                icon: Icon(Icons.cancel, size: 18.0),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) => controller.clear());
                  model.changeState(to: SignViewState.ready);
                },
              ),
            ),
            onChanged: (value) => onChanged(value),
            onEditingComplete: onComplete,
          ),
        )
    );
  }
}
