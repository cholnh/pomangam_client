import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/di/injector_register.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:pomangam_client/provider/sign/sign_in_model.dart';
import 'package:pomangam_client/provider/sign/sign_up_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/ui/page/common/splash_page.dart';
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
        ChangeNotifierProvider(create: (_) => SignUpModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => SignInModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => DeliverySiteModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => DeliveryDetailSiteModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => OrderTimeModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreSummaryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreModel(), lazy: true),
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
