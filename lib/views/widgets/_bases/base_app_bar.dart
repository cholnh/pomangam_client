import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';

class BaseAppBar extends AppBar {
  BaseAppBar() : super(
    centerTitle: false,
    automaticallyImplyLeading: false,
    elevation: 0.8,
    title :InkWell(
      child: Row(
        children: <Widget>[
          const Text('한국항공대 기숙사식당', style: TextStyle(fontSize: appBarFontSize, color: Colors.black)),
          const Icon(Icons.arrow_drop_down, color: Colors.black)
        ],
      ),
      onTap: () => print('tab!'),
    ),
  );
}
