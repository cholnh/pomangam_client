import 'package:pomangam_client/domain/temp/todo.dart';
import 'package:pomangam_client/repository/common/crud_repository_impl.dart';

class TodoRepository extends CrudRepositoryImpl<Todo> {

  TodoRepository({url}): super(url: url);
}