import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/domain/delivery/detail/delivery_detail_site.dart';

class DeliveryDetailSiteRepository {
  final Api api; // 서버 연결용
  DeliveryDetailSiteRepository({this.api});

  Future<List<DeliveryDetailSite>> findAll({int didx}) async
    => DeliveryDetailSite.fromJsonList((await api.get(url: '/dsites/$didx/details')).data);

  Future<DeliveryDetailSite> findByIdx({int didx, int ddidx}) async
    => DeliveryDetailSite.fromJson((await api.get(url: '/dsites/$didx/details/$ddidx')).data);
}