import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/di/injector_register.dart';
import 'package:pomangam_client/_bases/i18n/i18n.dart';
import 'package:pomangam_client/_bases/router/app_router.dart';
import 'package:pomangam_client/providers/advertisement/advertisement_model.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:pomangam_client/providers/payment/payment_model.dart';
import 'package:pomangam_client/providers/policy/policy_model.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:pomangam_client/providers/product/product_summary_model.dart';
import 'package:pomangam_client/providers/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:pomangam_client/providers/sign/sign_up_model.dart';
import 'package:pomangam_client/providers/store/store_model.dart';
import 'package:pomangam_client/providers/store/store_product_category_model.dart';
import 'package:pomangam_client/providers/store/store_summary_model.dart';
import 'package:pomangam_client/providers/tab/tab_model.dart';
import 'package:pomangam_client/views/pages/_bases/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  InjectorRegister.register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter router = Injector.appInstance.getDependency<AppRouter>();

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => SignUpModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => SignInModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => DeliverySiteModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => DeliveryDetailSiteModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => OrderTimeModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreSummaryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreProductCategoryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => ProductModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => ProductSummaryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => ProductSubCategoryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => AdvertisementModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => CartModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => PaymentModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => PolicyModel(), lazy: true),

      ],
      child: MaterialApp(
        title: '${Messages.appName}',
        theme: ThemeData(
          primarySwatch: primarySwatch,
          primaryColor: primaryColor,
          accentColor: primaryColor,
          canvasColor: backgroundColor,
          appBarTheme: AppBarTheme(
            color: backgroundColor
          ),
        ),
        darkTheme: ThemeData.dark(),
        home: SplashPage(),
        localizationsDelegates: [
          AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,

          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        supportedLocales: [Locale('ko'), Locale('en')],
        onGenerateRoute: router.generator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
