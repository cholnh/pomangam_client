import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/network/domain/page_request.dart';
import 'package:pomangam_client/domain/temp/todo_dto.dart';
import 'package:pomangam_client/repository/temp/todo_repository.dart';

class TodoModel with ChangeNotifier {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  List<TodoDto> todos = List();
  bool hasReachedMax = false;
  TodoRepository _todoRepository;

  int curPage = 0;
  int size = 10;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  TodoModel() {
    _todoRepository = Injector.appInstance.getDependency<TodoRepository>();
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  fetch({Function networkErrorHandler}) async {
    if(hasReachedMax) return;

    List<TodoDto> fetched = TodoDto.fromEntities(
        await _todoRepository.find(PageRequest(
          page: curPage++,
          size: size)));

    todos.addAll(fetched);

    int listCount = await _todoRepository.count();
    hasReachedMax = listCount <= todos.length;
    notifyListeners();
  }

  toggle(idx) async {
    for(TodoDto todo in todos) {
      if(todo.idx == idx) {
        todo.completed = !todo.completed;
        await _todoRepository.update(todo.toEntity());
        notifyListeners();
        break;
      }
    }
  }

  List<TodoDto> getCompleted()
  => todos.where((todo) => todo.completed).toList();

  List<TodoDto> getInCompleted()
  => todos.where((todo) => !todo.completed).toList();

  insert(TodoDto todo) async
  => TodoDto.fromEntity(await _todoRepository.insert(todo.toEntity()));

  delete(int idx) async
  => await _todoRepository.delete(idx);

  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}