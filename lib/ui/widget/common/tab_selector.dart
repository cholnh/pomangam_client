import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/domain/tab/tab_menu.dart';
import 'package:pomangam_client/ui/widget/common/custom_bottom_navbar_item.dart';

class TabSelector extends StatelessWidget {
  final TabMenu activeTab;
  final Function(TabMenu) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color selectedItemColor = Colors.black;
    final Color unselectedItemColor = Colors.grey;

    return SizedBox(
      height: 49,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: BottomNavigationBar(
          key: PmgKeys.baseTab,
          type: BottomNavigationBarType.fixed,
          currentIndex: TabMenu.values.indexOf(activeTab),
          onTap: (index) => onTabSelected(TabMenu.values[index]),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          backgroundColor: backgroundColor,
          selectedItemColor: selectedItemColor,
          unselectedItemColor: unselectedItemColor,
          items: [
            CustomBottomNavBarItem(
                icon: const Icon(Icons.local_dining, key: PmgKeys.tabHomeImg),
                title: Messages.tabHomeTitle,
                isActive: false,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unselectedItemColor
            ),
            CustomBottomNavBarItem(
                icon: const Icon(Icons.fastfood, key: PmgKeys.tabRecommendImg),
                title: Messages.tabRecommendTitle,
                isActive: false,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unselectedItemColor
            ),
            CustomBottomNavBarItem(
                icon: const Icon(Icons.event_note, key: PmgKeys.tabOrderInfoImg),
                title: Messages.tabOrderInfoTitle,
                isActive: true,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unselectedItemColor
            ),
            CustomBottomNavBarItem(
                icon: const Icon(Icons.more_horiz, key: PmgKeys.tabMoreImg),
                title: Messages.tabMoreTitle,
                isActive: true,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unselectedItemColor
            ),
          ]
        ),
      ),
    );
  }
}