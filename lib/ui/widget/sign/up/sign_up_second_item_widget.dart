import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpSecondItemWidget extends StatelessWidget {
  final Animation animation;

  final TextEditingController birthController;
  final FocusNode birthNode;
  final Function(String) onChangedBirth;
  final Function onCompleteBirth;

  final TextEditingController sexController;
  final FocusNode sexNode;
  final Function(String) onChangedSex;
  final Function onCompleteSex;

  SignUpSecondItemWidget({this.animation, this.birthController, this.birthNode,
      this.onChangedBirth, this.onCompleteBirth, this.sexController,
      this.sexNode, this.onChangedSex, this.onCompleteSex});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: birthController,
                  focusNode: birthNode,
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: '주민등록번호',
                      alignLabelWithHint: true
                  ),
                  onChanged: (value) => onChangedBirth(value),
                  onEditingComplete: onCompleteBirth,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('-', style: TextStyle(fontSize: 20.0)),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 20,
                      child: TextFormField(
                        controller: sexController,
                        focusNode: sexNode,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: '',
                        ),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.center,
                        onChanged: (value) => onChangedSex(value),
                        onEditingComplete: onCompleteSex,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 12.0),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.brightness_1, size: 18.0),
                          const Icon(Icons.brightness_1, size: 18.0),
                          const Icon(Icons.brightness_1, size: 18.0),
                          const Icon(Icons.brightness_1, size: 18.0),
                          const Icon(Icons.brightness_1, size: 18.0),
                          const Icon(Icons.brightness_1, size: 18.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
