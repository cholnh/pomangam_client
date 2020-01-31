
import 'package:pomangam_client/domain/temp/todo.dart';

class TodoDto {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  int idx;
  String username;
  String title;
  String contents;
  bool completed;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  TodoDto({
    this.idx,
    this.username,
    this.title,
    this.contents,
    this.completed});
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  Todo toEntity() => Todo(
    idx: idx,
    username: username,
    title: title,
    contents: contents,
    completed: completed
  );

  static List<Todo> toEntities(List<TodoDto> dtos)
    => dtos.map((dto) => dto.toEntity()).toList();

  static TodoDto fromEntity(Todo entity) => TodoDto(
    idx: entity.idx,
    username: entity.username,
    title: entity.title,
    contents: entity.contents,
    completed: entity.completed ?? false,
  );

  static List<TodoDto> fromEntities(List<Todo> entities)
    => entities.map((entity) => fromEntity(entity)).toList();

  TodoDto copyWith({int idx, String username, String title, String contents, bool completed}) {
    return TodoDto(
      idx: idx ?? this.idx,
      username: username ?? this.username,
      title: title ?? this.title,
      contents: contents ?? this.contents,
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() {
    return 'TodoDto{idx: $idx, username: $username, title: $title, contents: $contents, completed: $completed}';
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}