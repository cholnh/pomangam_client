import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';

class CustomIcon extends StatelessWidget {
  final Icon icon;
  final bool isActive;

  const CustomIcon({this.icon, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return isActive
      ? Container(
          child: Stack(
            children: <Widget>[
              IconButton(
                icon: icon,
              ),
              Positioned(
                top: 7,
                right: 7,
                child: Stack(
                  children: <Widget>[
                    const Icon(Icons.brightness_1, size: 7.0, color: primaryColor)
                  ],
                ),
              )
            ],
          )
        )
      : IconButton(
          icon: icon,
        );
  }
}
