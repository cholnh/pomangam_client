import 'package:fluro/fluro.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/network/repository/authorization_repository.dart';
import 'package:pomangam_client/common/network/repository/resource_repository.dart';
import 'package:pomangam_client/common/network/service/network_service.dart';
import 'package:pomangam_client/common/network/service/network_service_impl.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/repository/store/store_repository.dart';
import 'package:pomangam_client/repository/temp/todo_repository.dart';

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
        oauthTokenRepository: injector.getDependency<OauthTokenRepository>()))


    /// A singleton NetworkService provider.
    ///
    /// Calling it multiple times will return the same instance.
    ..registerDependency<NetworkService>
      ((injector) => NetworkServiceImpl(
        oauthTokenRepository: injector.getDependency<OauthTokenRepository>(),
        resourceRepository: injector.getDependency<ResourceRepository>()))


    /// A singleton TodoRepository provider.
    ///
    /// Calling it multiple times will return the same instance.
    ..registerDependency<TodoRepository>
      ((injector) => TodoRepository(
        url: 'todos'))


    /// A singleton StoreRepository provider.
    ///
    /// Calling it multiple times will return the same instance.
    ..registerDependency<StoreRepository>
      ((injector) => StoreRepository(
        url: 'stores',
        networkService: injector.getDependency<NetworkService>()));

    }
}