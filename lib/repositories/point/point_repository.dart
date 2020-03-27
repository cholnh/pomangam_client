import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/domains/user/point_log/point_log.dart';

class PointRepository {

  final Api api; // 서버 연결용
  PointRepository({this.api});

  Future<List<PointLog>> findAll() async
    => PointLog.fromJsonList((await api.get(url: '/users/-/points')).data);
}