import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/domain/temp/todo_dto.dart';

class TodoListItem extends StatelessWidget {
  final TodoDto todo;
  final ValueChanged<bool> onCheckboxChanged;

  const TodoListItem({
    Key key,
    @required this.todo,
    @required this.onCheckboxChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('__todoItem_${todo.idx.toString()}__'),
      leading: Checkbox(
        key: Key('__todoItemCheckbox_${todo.idx.toString()}__'),
        value: todo.completed,
        onChanged: onCheckboxChanged,
      ),
      title: Text(todo.title),
      isThreeLine: true,
      subtitle: Text(todo.contents),
      dense: true,
    );
  }
}