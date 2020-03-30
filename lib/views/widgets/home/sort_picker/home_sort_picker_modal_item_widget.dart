import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/sort/sort_type.dart';

class HomeSortPickerModalItemWidget extends StatelessWidget {

  final SortType type;
  final bool isSelected;
  final Function(SortType) onSelected;

  HomeSortPickerModalItemWidget({this.type, this.isSelected = false, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        title: isSelected
            ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('${convertSortTypeToText(type)}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: primaryColor)),
            const Padding(padding: EdgeInsets.all(3)),
            const Icon(Icons.check, color: primaryColor, size: 18.0)
          ],
        )
            : Text('${convertSortTypeToText(type)}', style: TextStyle(fontSize: 14.0)),
        onTap: () => onSelected(type),
      )
    );
  }
}
