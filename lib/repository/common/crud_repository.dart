import 'package:pomangam_client/common/network/domain/page_request.dart';

abstract class  CrudRepository<T> {
  Future<int> count();

  Future<List<T>> find(PageRequest pageRequest);

  Future<List<T>> findAll();

  Future<T> findById(int id);

  Future<T> insert(T entity);

  Future<T> update(T entity);

  delete(int id);
}