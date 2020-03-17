import 'package:flutter/material.dart';
import 'package:pomangam_client/views/widgets/_bases/custom_icon.dart';

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  CustomBottomNavBarItem({Key key, icon, title, isActive = false, Color unselectedItemColor, Color selectedItemColor}) : super(
      icon: CustomIcon(
        icon: Icon(icon.icon, color: unselectedItemColor, key: key),
        isActive: isActive),
      activeIcon: CustomIcon(
        icon: Icon(icon.icon, color: selectedItemColor, key: key),
        isActive: isActive),
      title: Text('$title')
  );
}
