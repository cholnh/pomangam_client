import 'package:pomangam_client/common/network/domain/page_request.dart';
import 'package:pomangam_client/common/network/service/network_service.dart';
import 'package:pomangam_client/repository/common/crud_repository.dart';
import 'package:pomangam_client/domain/common/entity.dart';

class CrudRepositoryImpl<T extends Entity> implements CrudRepository<T> {

  final String url;
  final T entityModel;
  final NetworkService networkService;

  CrudRepositoryImpl({this.url, this.entityModel, this.networkService});

  @override
  Future<int> count() async
  => await networkService.get(url: '/$url/size');

  @override
  Future<List<T>> find(PageRequest pageRequest) async {
    var res = await networkService.get(url: '/$url?page=${pageRequest.page}&size=${pageRequest.size}');

    List<T> entities = [];

    res.forEach((map) => entities.add(entityModel.fromJson(map)));
    return entities;
  }

  @override
  Future<List<T>> findAll() async {
    var res = await networkService.get(url: '/$url');

    List<T> entities = [];

    res.forEach((map) => entities.add(entityModel.fromJson(map)));
    return entities;
  }

  @override
  Future<T> findById(int id) async {
    var res = await networkService.get(url: '/$url/$id');
    return entityModel.fromJson(res);
  }

  @override
  Future<T> insert(T entity) async
  => entityModel.fromJson(await networkService.post(url: '/$url', jsonData: entity.toJson()));

  @override
  Future<T> update(T entity) async
  => entityModel.fromJson(await networkService.put(url: '/$url', jsonData: entity.toJson()));

  @override
  delete(int idx) async
  => await networkService.delete(url: '/$url/$idx');

}