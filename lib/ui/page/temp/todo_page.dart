import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/temp/todo_model.dart';
import 'package:pomangam_client/ui/widget/temp/todo_bottom_loader.dart';
import 'package:pomangam_client/ui/widget/temp/todo_list_item.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {

  TodoPage({Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TodoModel _todoModel = Provider.of<TodoModel>(context);
    return ListView.separated(
      key: Key('__todoListView__'),
      itemBuilder: (context, index) {
        return index >= _todoModel.todos.length
            ? BottomLoader()
            : TodoListItem(
                todo: _todoModel.todos[index],
                onCheckboxChanged: (isUnChecked) {
                  _todoModel.toggle(_todoModel.todos[index].idx);
                });
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _todoModel.hasReachedMax
          ? _todoModel.todos.length
          : _todoModel.todos.length + 1,
      controller: _scrollController,
    );

  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      Provider.of<TodoModel>(context, listen: false).fetch();
    }
  }
}
