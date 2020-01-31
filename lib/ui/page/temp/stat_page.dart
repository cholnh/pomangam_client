import 'package:flutter/material.dart';
import 'package:pomangam_client/common/network/provider/user_model.dart';
import 'package:pomangam_client/provider/temp/todo_model.dart';
import 'package:provider/provider.dart';

class StatPage extends StatelessWidget {
  StatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<TodoModel>(
              builder: (_, model, child) {
                int total = model.todos.length;
                int completed = model.getCompleted().length;
                int inCompleted = model.getInCompleted().length;
                return Text(
                  'Todo in Provider : $total($completed/$inCompleted)',
                );
              }
            ),
            Consumer<UserModel>(
                builder: (_, model, child) {
                  return Text(
                    'Sign state : ${model.signState.toString()}',
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
