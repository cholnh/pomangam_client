import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/domains/deliverysite/detail/delivery_detail_site.dart';

class DeliveryDetailSiteRepository {
  final Api api; // 서버 연결용
  DeliveryDetailSiteRepository({this.api});

  Future<List<DeliveryDetailSite>> findAll({int dIdx}) async
    => DeliveryDetailSite.fromJsonList((await api.get(url: '/dsites/$dIdx/details')).data);

  Future<DeliveryDetailSite> findByIdx({int dIdx, int ddIdx}) async
    => DeliveryDetailSite.fromJson((await api.get(url: '/dsites/$dIdx/details/$ddIdx')).data);
}