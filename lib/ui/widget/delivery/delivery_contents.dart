import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/ui/widget/delivery/delivery_contents_item.dart';

class DeliveryContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TodoModel _todoModel = Provider.of<TodoModel>(context);
    return SliverList(
      key: PmgKeys.deliveryContents,
      delegate: SliverChildBuilderDelegate(
        (context, index) {

          return DeliveryContentsItem();


//          return index >= _todoModel.todos.length
//            ? BottomLoader()
//            : TodoListItem(
//              todo: _todoModel.todos[index],
//              onCheckboxChanged: (isUnChecked) {
//                _todoModel.toggle(_todoModel.todos[index].idx);
//              });
        },
          childCount: 3
//        childCount: _todoModel.hasReachedMax
//            ? _todoModel.todos.length
//            : _todoModel.todos.length + 1
      ),
    );
  }
}
