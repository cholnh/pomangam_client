import 'package:fluro/fluro.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/network/api/api.dart';
import 'package:pomangam_client/common/network/repository/authorization_repository.dart';
import 'package:pomangam_client/common/network/repository/resource_repository.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/common/initalizer/initializer.dart';
import 'package:pomangam_client/repository/sign/sign_repository.dart';
import 'package:pomangam_client/repository/store/store_repository.dart';

class InjectorRegister {

  static register() {
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
        api: injector.getDependency<Api>()
      ))


    /// A singleton Initializer provider.
    ///
    /// Calling it multiple times will return the same instance.
    ..registerDependency<Initializer>
      ((injector) => Initializer(
        api: injector.getDependency<Api>()
      ));



    }
}