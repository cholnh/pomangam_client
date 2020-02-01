import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/di/injector_register.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';
import 'package:pomangam_client/common/network/provider/user_model.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/provider/tab/tab_model.dart';
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
        ChangeNotifierProvider(create: (_) => StoreSummaryModel()),
        ChangeNotifierProvider(create: (_) => TabModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),

      ],
      child: MaterialApp(
        title: '${Messages.appName}',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          canvasColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.white
          ),
        ),
        darkTheme: ThemeData.dark(),
        home: SplashPage(),
        localizationsDelegates: [
          AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [Locale("en"), Locale("ko")],
        onGenerateRoute: router.generator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
