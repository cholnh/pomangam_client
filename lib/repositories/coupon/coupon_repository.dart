import 'package:flutter/foundation.dart';
import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/domains/coupon/coupon.dart';

class CouponRepository {
  final Api api; // 서버 연결용
  CouponRepository({this.api});

  Future<List<Coupon>> findAll() async
  => Coupon.fromJsonList((await api.get(url: '/users/-/coupons')).data);

  Future<Coupon> findByCode({
    @required String code
  }) async
  => Coupon.fromJson((await api.get(url: '/users/-/coupons?code=$code')).data);

  Future<Coupon> findByIdx({
    @required int cIdx
  }) async
  => Coupon.fromJson((await api.get(url: '/users/-/coupons/$cIdx')).data);

  Future<Coupon>  saveByCode({
    @required String code
  }) async
  => Coupon.fromJson((await api.post(url: '/users/-/coupons/$code')).data);

}