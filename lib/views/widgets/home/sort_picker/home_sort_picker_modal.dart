import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/i18n/i18n.dart';
import 'package:pomangam_client/domains/sort/sort_type.dart';
import 'package:pomangam_client/views/widgets/home/sort_picker/home_sort_picker_modal_item_widget.dart';

class HomeSortPickerModal extends StatelessWidget {

  final SortType type;
  final Function(SortType) onSelected;

  HomeSortPickerModal({this.type, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  '${Messages.sortPickerTitle}',
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  )
                ),
              ),
              Divider(height: 0.0, thickness: 8.0, color: Colors.black.withOpacity(0.03)),
              HomeSortPickerModalItemWidget(
                type: SortType.SORT_BY_RECOMMEND_DESC,
                isSelected: type == SortType.SORT_BY_RECOMMEND_DESC,
                onSelected: onSelected,
              ),
              const Divider(height: 0.1),
              HomeSortPickerModalItemWidget(
                type: SortType.SORT_BY_ORDER_DESC,
                isSelected: type == SortType.SORT_BY_ORDER_DESC,
                onSelected: onSelected,
              ),
              const Divider(height: 0.1),
              HomeSortPickerModalItemWidget(
                type: SortType.SORT_BY_STAR_DESC,
                isSelected: type == SortType.SORT_BY_STAR_DESC,
                onSelected: onSelected,
              ),
              const Divider(height: 0.1),
              HomeSortPickerModalItemWidget(
                type: SortType.SORT_BY_REVIEW_DESC,
                isSelected: type == SortType.SORT_BY_REVIEW_DESC,
                onSelected: onSelected,
              ),
              const Divider(height: 0.1),
            ],
          )
        ],
      ),
    );
  }
}
