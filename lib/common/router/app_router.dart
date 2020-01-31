import 'package:fluro/fluro.dart';
import 'package:pomangam_client/ui/page/common/base_page.dart';
import 'package:pomangam_client/ui/page/common/error_page.dart';
import 'package:pomangam_client/ui/page/common/not_found_page.dart';

class AppRouter extends Router {
  void configureRoutes() {

    /// A HomePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/",
      handler:  Handler(handlerFunc: (context, params) {
        return BasePage();
      }),
      transitionType: TransitionType.material);


    /// A HomePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/error/:msg",
      handler:  Handler(handlerFunc: (context, params) {
        return ErrorPage(contents: params['msg'][0]);
      }),
      transitionType: TransitionType.material);


    /// A NotFoundPage router path.
    ///
    /// When an unknown path is called, Returns the page specified in the handler.
    super.notFoundHandler =
      Handler(handlerFunc: (context, params) {
        return NotFoundPage();
    });
  }
}