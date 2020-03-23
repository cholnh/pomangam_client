import 'dart:developer';

import 'package:fluro/fluro.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/initalizer/initializer.dart';
import 'package:pomangam_client/_bases/network/api/api.dart';
import 'package:pomangam_client/_bases/network/repository/authorization_repository.dart';
import 'package:pomangam_client/_bases/network/repository/resource_repository.dart';
import 'package:pomangam_client/_bases/router/app_router.dart';
import 'package:pomangam_client/repositories/advertisement/advertisement_repository.dart';
import 'package:pomangam_client/repositories/delivery/delivery_site_repository.dart';
import 'package:pomangam_client/repositories/delivery/detail/delivery_detail_site_repository.dart';
import 'package:pomangam_client/repositories/order/order_repository.dart';
import 'package:pomangam_client/repositories/order/time/order_time_repository.dart';
import 'package:pomangam_client/repositories/policy/policy_repository.dart';
import 'package:pomangam_client/repositories/product/product_repository.dart';
import 'package:pomangam_client/repositories/product/sub/product_sub_repository.dart';
import 'package:pomangam_client/repositories/sign/sign_repository.dart';
import 'package:pomangam_client/repositories/store/store_repository.dart';

class InjectorRegister {

  static register() {
    try {
      log('start injector register', name: 'InjectorRegister.register', time: DateTime.now());
      Injector.appInstance

      /// A singleton OauthTokenRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerSingleton<Router>
          ((_) => Router())


      /// A singleton OauthTokenRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerSingleton<AppRouter>
          ((injector) {
          AppRouter router = AppRouter();
          router.configureRoutes();
          return router;
        })


      /// A singleton OauthTokenRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerSingleton<OauthTokenRepository>
          ((_) => OauthTokenRepository())


      /// A singleton ResourceRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerSingleton<ResourceRepository>
          ((injector) => ResourceRepository(
            oauthTokenRepository: injector.getDependency<OauthTokenRepository>()
        ))


      /// A singleton NetworkService provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<Api>
          ((injector) => Api(
            oauthTokenRepository: injector.getDependency<OauthTokenRepository>(),
            resourceRepository: injector.getDependency<ResourceRepository>()
        ))


      /// A singleton StoreRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<StoreRepository>
          ((injector) => StoreRepository(
            api: injector.getDependency<Api>()
        ))


      /// A singleton SignRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<SignRepository>
          ((injector) => SignRepository(
            api: injector.getDependency<Api>(),
            initializer: injector.getDependency<Initializer>()
        ))


      /// A singleton Initializer provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<Initializer>
          ((injector) => Initializer(
            api: injector.getDependency<Api>()
        ))


      /// A singleton DeliveryDetailSiteRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<DeliveryDetailSiteRepository>
          ((injector) => DeliveryDetailSiteRepository(
            api: injector.getDependency<Api>()
        ))


      /// A singleton DeliverySiteRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<DeliverySiteRepository>
          ((injector) => DeliverySiteRepository(
            api: injector.getDependency<Api>()
        ))


      /// A singleton OrderRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<OrderRepository>
          ((injector) => OrderRepository(
            api: injector.getDependency<Api>()
        ))


      /// A singleton OrderTimeRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<OrderTimeRepository>
          ((injector) => OrderTimeRepository(
            api: injector.getDependency<Api>()
        ))


      /// A singleton ProductRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<ProductRepository>
          ((injector) => ProductRepository(
            api: injector.getDependency<Api>()
        ))

      /// A singleton ProductSubRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<ProductSubRepository>
          ((injector) => ProductSubRepository(
            api: injector.getDependency<Api>()
        ))

      /// A singleton AdvertisementRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<AdvertisementRepository>
          ((injector) => AdvertisementRepository(
            api: injector.getDependency<Api>()
        ))

      /// A singleton PolicyRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<PolicyRepository>
          ((injector) => PolicyRepository(
            api: injector.getDependency<Api>()
        ));



      log('success', name: 'InjectorRegister.register', time: DateTime.now());
    } catch (error) {
      log('fail', name: 'InjectorRegister.register', time: DateTime.now(), error: error);
    }
  }
}