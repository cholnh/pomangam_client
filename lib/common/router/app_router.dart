import 'package:fluro/fluro.dart';
import 'package:pomangam_client/provider/sign/sign_up_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/provider/tab/tab_model.dart';
import 'package:pomangam_client/ui/page/common/base_page.dart';
import 'package:pomangam_client/ui/page/common/error_page.dart';
import 'package:pomangam_client/ui/page/common/not_found_page.dart';
import 'package:pomangam_client/ui/page/sign/in/sign_in_page.dart';
import 'package:pomangam_client/ui/page/sign/up/sign_up_authcode_page.dart';
import 'package:pomangam_client/ui/page/sign/up/sign_up_nickname_page.dart';
import 'package:pomangam_client/ui/page/sign/up/sign_up_page.dart';
import 'package:pomangam_client/ui/page/sign/up/sign_up_password_page.dart';
import 'package:pomangam_client/ui/page/store/store_page.dart';
import 'package:provider/provider.dart';

class AppRouter extends Router {
  void configureRoutes() {

    /// A HomePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/",
      handler:  Handler(handlerFunc: (context, params) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TabModel(), lazy: true),
          ],
          child: BasePage(),
        );
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


    /// A StorePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/dsites/:didx/stores/:sidx",
      handler: Handler(handlerFunc: (context, params) {
        int didx = int.parse(params['didx'][0]);
        int sidx = int.parse(params['sidx'][0]);
        return ChangeNotifierProvider<StoreModel>(
          create: (_) => StoreModel()..fetch(didx: didx, sidx: sidx),
          child: StorePage(),
          lazy: true
        );
      }),
      transitionType: TransitionType.material);


    /// A SignIn router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signin",
      handler: Handler(handlerFunc: (context, params) {
        return SignInPage();
      }),
      transitionType: TransitionType.materialFullScreenDialog);


    /// A SignUp router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signup",
      handler: Handler(handlerFunc: (context, params) {
        return SignUpPage();
      }),
      transitionType: TransitionType.materialFullScreenDialog);


    /// A SignUpAuthCodePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signup/authcode",
      handler: Handler(handlerFunc: (context, params) {
        return SignUpAuthCodePage();
      }),
      transitionType: TransitionType.material);


    /// A SignUpPasswordPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signup/password",
      handler: Handler(handlerFunc: (context, params) {
        return SignUpPasswordPage();
      }),
      transitionType: TransitionType.material);


    /// A SignUpNicknamePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signup/nickname",
      handler: Handler(handlerFunc: (context, params) {
        return SignUpNicknamePage();
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