import 'package:flutter/material.dart';
import 'package:pomangam_client/ui/widget/common/custom_icon.dart';

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  CustomBottomNavBarItem({icon, title, isActive = false, Key key}) : super(
      icon: CustomIcon(
        icon: Icon(icon.icon, color: Colors.grey, key: key),
        isActive: isActive),
      activeIcon: CustomIcon(
        icon: Icon(icon.icon, color: Colors.deepOrange, key: key),
        isActive: isActive),
      title: Text('$title')
  );
}
