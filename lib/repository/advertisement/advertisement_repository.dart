import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/domain/advertisement/advertisement.dart';
import 'package:pomangam_client/domain/deliverysite/detail/delivery_detail_site.dart';

class AdvertisementRepository {
  final Api api; // 서버 연결용
  AdvertisementRepository({this.api});

  Future<List<Advertisement>> findAll({int dIdx}) async
    => Advertisement.fromJsonList((await api.get(url: '/dsites/$dIdx/advertisements')).data);
}