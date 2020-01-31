import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/ui/widget/delivery/sort_picker_modal.dart';
import 'package:pomangam_client/ui/widget/delivery/time_picker_modal.dart';

class DeliveryContentsBar extends StatefulWidget {
  @override
  _DeliveryContentsBarState createState() => _DeliveryContentsBarState();
}

class _DeliveryContentsBarState extends State<DeliveryContentsBar> {
  int time = 12;
  int sort = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: PmgKeys.deliveryContentsBar,
      backgroundColor: Colors.white,
      floating: false,
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 0.8,
      title :InkWell(
        child: Row(
          children: <Widget>[
            Text('$time시 도착', style: const TextStyle(fontSize: 18, color: Colors.black)),
            Icon(Icons.arrow_drop_down, color: Colors.black)
          ],
        ),
        onTap: () => _showModal(
          widget: TimePickerModal(time: time, onSelected: _selectTime)
        ),
      ),
      actions: <Widget>[
        const IconButton(
          icon: const Icon(Icons.view_module, color: Colors.grey),
        ),
        IconButton(
          icon: const Icon(Icons.filter_list, color: Colors.grey),
          onPressed: () => _showModal(
              widget: SortPickerModal(sort: sort, onSelected: _selectSort)
          ),
        )
      ],
    );
  }

  _showModal({Widget widget}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (context) {
          return widget;
        }
    );
  }

  _selectTime(time) {
    Navigator.pop(context);
    setState(() {
      this.time = time;
    });
  }

  _selectSort(sort) {
    Navigator.pop(context);
    setState(() {
      this.sort = sort;
    });
  }
}
