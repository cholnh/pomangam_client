import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBottomLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}