import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class ProductCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
          child: Text(
            '수량',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(
                      width: 1.5,
                      color: primaryColor
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: backgroundColor, size: titleFontSize),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(
                      width: 1.5,
                      color: primaryColor
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.remove, color: backgroundColor, size: titleFontSize),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
