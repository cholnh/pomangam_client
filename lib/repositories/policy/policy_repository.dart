import 'package:pomangam_client/_bases/network/api/api.dart';

class PolicyRepository {

  final Api api; // 서버 연결용

  PolicyRepository({this.api});

  Future<String> privacy() async => (await api.get(url: '/policies/privacy')).data;

  Future<String> terms() async => (await api.get(url: '/policies/terms')).data;

}