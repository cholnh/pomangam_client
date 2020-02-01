import 'package:pomangam_client/common/network/domain/page_request.dart';
import 'package:pomangam_client/common/network/service/network_service.dart';
import 'package:pomangam_client/domain/store/store_entity.dart';
import 'package:pomangam_client/domain/store/store_summary_entity.dart';
import 'package:pomangam_client/repository/common/crud_repository_impl.dart';

class StoreRepository extends CrudRepositoryImpl<StoreEntity> {

  final NetworkService networkService;

  StoreRepository({url, this.networkService})
      : super(url: url, networkService: networkService);

  Future<List<StoreSummaryEntity>> findByType({
    int deliverySiteIdx,
    int type,
    PageRequest pageRequest
  }) async {

    final path = '/search/findByType';
    List<StoreSummaryEntity> entities = [];

    var res = await networkService.get(
        url: '/$url$path?deliverySiteIdx=$deliverySiteIdx&type=$type&page=${pageRequest.page}&size=${pageRequest.size}');

    res.forEach((map) => entities.add(StoreSummaryEntity().fromJson(map)));

    return entities;
  }
}