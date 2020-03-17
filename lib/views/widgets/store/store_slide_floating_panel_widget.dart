import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class StoreSlideFloatingPanelWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]
      ),
      margin: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: GestureDetector(
                child: Container(
                  color: primaryColor,
                  width: MediaQuery.of(context).size.width,
                  height: 53.0,
                  child: Center(
                    child: Text('결제하기', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)),
                  ),
                ),
                onTap: () => print('결제 page 이동'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
