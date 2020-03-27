import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client/domains/user/enum/sign_view_state.dart';
import 'package:pomangam_client/providers/sign/sign_up_model.dart';

class SignUpThirdItemWidget extends StatelessWidget {
  final Animation animation;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function onComplete;
  final SignUpModel model;

  SignUpThirdItemWidget({this.animation, this.controller, this.focusNode,
      this.onChanged, this.onComplete, this.model});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.phone,
            autocorrect: false,
            style: TextStyle(fontWeight: FontWeight.bold),
            textInputAction: TextInputAction.done,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
            ],
            decoration: InputDecoration(
              labelText: '휴대폰 번호',
              suffixIcon: IconButton(
                padding: EdgeInsets.only(top: 15.0),
                icon: Icon(Icons.cancel, size: 18.0),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.clear();
                    model.changeState(to: SignViewState.phone);
                  });
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
