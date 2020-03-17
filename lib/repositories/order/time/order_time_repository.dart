import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/domains/order/time/order_time.dart';

class OrderTimeRepository {
  final Api api; // 서버 연결용
  OrderTimeRepository({this.api});

  Future<List<OrderTime>> findByIdxDeliverySite({int dIdx}) async
    => OrderTime.fromJsonList((await api.get(url: '/dsites/$dIdx/ordertimes')).data);

}