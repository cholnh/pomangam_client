import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/domains/coupon/coupon.dart';
import 'package:pomangam_client/repositories/coupon/coupon_repository.dart';

class CouponModel with ChangeNotifier {

  CouponRepository _couponRepository;

  List<Coupon> coupons = List();
  Coupon searchCoupon;

  bool isCouponsFetching = false;
  bool isCouponsSearching = false;

  CouponModel() {
    _couponRepository = Injector.appInstance.getDependency<CouponRepository>();
  }

  Future<void> fetchAll() async {
    isCouponsFetching = true;
    try {
      this.coupons = await _couponRepository.findAll();
      print(coupons.length);
    } catch (error) {
      print('[Debug] CouponModel.fetch Error - $error');
      this.isCouponsFetching = false;
    }
    this.isCouponsFetching = false;
    notifyListeners();
  }

  Future<void> fetchOne({
    @required String code
  }) async {
    isCouponsSearching = true;
    try {
      this.searchCoupon = await _couponRepository.findByCode(code: code);
    } catch (error) {
      print('[Debug] CouponModel.fetchOne Error - $error');
      this.isCouponsSearching = false;
    }
    this.isCouponsSearching = false;
    notifyListeners();
  }

  Future<void> saveByCode({
    @required String code
  }) async {
    isCouponsSearching = true;
    try {
      this.searchCoupon = await _couponRepository.saveByCode(code: code);
    } catch (error) {
      print('[Debug] CouponModel.saveByCode Error - $error');
      this.isCouponsSearching = false;
    }
    this.isCouponsSearching = false;
    notifyListeners();
  }

  void clear({bool notify = false}) {
    coupons.clear();
    searchCoupon = null;

    if(notify) {
      notifyListeners();
    }
  }
}