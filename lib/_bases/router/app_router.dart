import 'package:fluro/fluro.dart';
import 'package:pomangam_client/views/pages/_bases/base_page.dart';
import 'package:pomangam_client/views/pages/_bases/error_page.dart';
import 'package:pomangam_client/views/pages/_bases/not_found_page.dart';
import 'package:pomangam_client/views/pages/deliverysite/delivery_site_page.dart';
import 'package:pomangam_client/views/pages/payment/agreement/payment_agreement_page.dart';
import 'package:pomangam_client/views/pages/payment/cash_receipt/payment_cash_receipt_page.dart';
import 'package:pomangam_client/views/pages/payment/coupon/payment_coupon_page.dart';
import 'package:pomangam_client/views/pages/payment/method/payment_method_page.dart';
import 'package:pomangam_client/views/pages/payment/payment_page.dart';
import 'package:pomangam_client/views/pages/payment/point/payment_point_page.dart';
import 'package:pomangam_client/views/pages/product/product_page.dart';
import 'package:pomangam_client/views/pages/sign/in/sign_in_page.dart';
import 'package:pomangam_client/views/pages/sign/up/sign_up_authcode_page.dart';
import 'package:pomangam_client/views/pages/sign/up/sign_up_nickname_page.dart';
import 'package:pomangam_client/views/pages/sign/up/sign_up_page.dart';
import 'package:pomangam_client/views/pages/sign/up/sign_up_password_page.dart';
import 'package:pomangam_client/views/pages/store/store_page.dart';

class AppRouter extends Router {
  void configureRoutes() {

    /// A NotFoundPage router path.
    ///
    /// When an unknown path is called, Returns the page specified in the handler.
    super.notFoundHandler =
      Handler(handlerFunc: (context, params) {
        return NotFoundPage();
    });


    /// A HomePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/",
      handler:  Handler(handlerFunc: (context, params) {
        return BasePage();
      }),
      transitionType: TransitionType.material
    );


    /// A HomePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/error/:msg",
      handler:  Handler(handlerFunc: (context, params) {
        return ErrorPage(contents: params['msg'][0]);
      }),
      transitionType: TransitionType.material
    );


    /// A StorePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/stores/:idx",
      handler: Handler(handlerFunc: (context, params) {
        int sIdx = int.parse(params['idx'][0]);
        return StorePage(sIdx: sIdx);
      }),
      transitionType: TransitionType.cupertino
    );


    /// A ProductPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/products/:idx",
      handler: Handler(handlerFunc: (context, params) {
        int pIdx = int.parse(params['idx'][0]);
        return ProductPage(pIdx: pIdx);
      }),
      transitionType: TransitionType.cupertino
    );


    /// A SignIn router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signin",
      handler: Handler(handlerFunc: (context, params) {
        return SignInPage();
      }),
      transitionType: TransitionType.materialFullScreenDialog
    );


    /// A SignUp router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signup",
      handler: Handler(handlerFunc: (context, params) {
        return SignUpPage();
      }),
      transitionType: TransitionType.materialFullScreenDialog
    );


    /// A SignUpAuthCodePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signup/authcode",
      handler: Handler(handlerFunc: (context, params) {
        return SignUpAuthCodePage();
      }),
      transitionType: TransitionType.cupertino
    );


    /// A SignUpPasswordPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signup/password",
      handler: Handler(handlerFunc: (context, params) {
        return SignUpPasswordPage();
      }),
      transitionType: TransitionType.cupertino
    );


    /// A SignUpNicknamePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/signup/nickname",
      handler: Handler(handlerFunc: (context, params) {
        return SignUpNicknamePage();
      }),
      transitionType: TransitionType.cupertino
    );


    /// A DeliverySitePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/dsites",
      handler: Handler(handlerFunc: (context, params) {
        return DeliverySitePage();
      }),
      transitionType: TransitionType.material
    );


    /// A PaymentPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/payments",
      handler: Handler(handlerFunc: (context, params) {
        return PaymentPage();
      }),
      transitionType: TransitionType.inFromBottom
    );


    /// A PaymentAgreementPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/payments/agreements",
      handler: Handler(handlerFunc: (context, params) {
        return PaymentAgreementPage();
      }),
      transitionType: TransitionType.cupertino
    );


    /// A PaymentMethodPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/payments/methods",
      handler: Handler(handlerFunc: (context, params) {
        return PaymentMethodPage();
      }),
      transitionType: TransitionType.cupertino
    );


    /// A PaymentCouponPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/payments/coupons",
      handler: Handler(handlerFunc: (context, params) {
        return PaymentCouponPage();
      }),
      transitionType: TransitionType.cupertino
    );


    /// A PaymentPointPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/payments/points",
      handler: Handler(handlerFunc: (context, params) {
        return PaymentPointPage();
      }),
      transitionType: TransitionType.cupertino
    );


    /// A PaymentCashReceiptPage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/payments/cashreceipts",
      handler: Handler(handlerFunc: (context, params) {
        return PaymentCashReceiptPage();
      }),
      transitionType: TransitionType.cupertino
    );


  }
}