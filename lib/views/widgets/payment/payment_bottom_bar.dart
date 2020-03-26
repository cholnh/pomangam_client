import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class PaymentBottomBar extends StatelessWidget {

  final String centerText;
  final bool isActive;
  final Function onSelected;
  final bool isVisible;

  PaymentBottomBar({this.centerText, this.isActive = true, this.onSelected, this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    if(isVisible) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: GestureDetector(
            onTap: isActive ? onSelected : () => {},
            child: Opacity(
              opacity: isActive ? 1.0 : 0.5,
              child: SizedBox(
                height: 65.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: primaryColor,
                    child: Center(
                      child: Text('$centerText', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 17.0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
