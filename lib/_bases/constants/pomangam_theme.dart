import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// primary color
/// #FE6E00
const num primaryColorRGB = 0xFE6E00FF;
const Color primaryColor = Color.fromRGBO(0xFE, 0x6E, 0x00, 1.0);
const MaterialColor primarySwatch = MaterialColor(
  primaryColorRGB, {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    }
);

/// secondary color
const Color secondaryColor = Colors.deepOrange;

/// background color
const Color backgroundColor = Colors.white;

/// sub text color
final Color subTextColor = Colors.black.withOpacity(0.5);

/// font size
const double appBarFontSize = 16.0;
const double titleFontSize = 13.0;
const double subTitleFontSize = 12.0;