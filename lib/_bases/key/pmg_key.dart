import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PmgKeys {

  // Error
  static final errorPage = GlobalKey();
  // Delivery
  static const deliveryPage = Key('__deliveryPage__');
  static const deliveryAdvertisement = Key('__deliveryAdvertisement__');
  static const deliveryContents = Key('__deliveryContents__');
  static const deliveryContentsBar = Key('__deliveryContentsBar__');
  // Tab
  static const baseTab = Key('__baseTab__');
  static const tabHomeImg = Key('__tabHomeImg__');
  static const tabRecommendImg = Key('__tabRecommendImg__');
  static const tabOrderInfoImg = Key('__tabOrderInfoImg__');
  static const tabMoreImg = Key('__tabMoreImg__');
  // Store
  static const storePage = Key('__storePage__');
  static const storeHeader = Key('__storeHeader__');
  static const storeDescription = Key('__storeDescription__');
  static const storeProductCategory = Key('__storeProductCategory__');
  static const storeStory = Key('__storeStory__');
  static const storeProduct = Key('__storeProduct__');
  static Key storeProductItem(int i) => Key('__storeProduct_${i}__');

  // Home
  static const homeContentsItemImage = Key('__homeContentsItemImage__');
  static Key homeContentsItem(int i) => Key('__homeContentsItem_${i}__');

  // Product
  static const productPage = Key('__productPage__');
  static const productImage = Key('__productImage__');
  static const productSubCategory = Key('__productSubCategory__');
}