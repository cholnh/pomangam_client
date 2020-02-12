import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/common/initalizer/initializer.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final AppRouter _router = Injector.appInstance.getDependency<AppRouter>();
  final Initializer _initializer = Injector.appInstance.getDependency<Initializer>();

  @override
  void initState() {
    super.initState();
    _readyInitialize(); // 초기화 준비
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Image(
              image: const AssetImage('assets/logo3.gif'),
              width: 150,
              height: 150,
            ),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(
              Messages.companyName,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            margin: const EdgeInsets.only(bottom: 50),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  _readyInitialize() async {
    // widget build 가 모두 완료된 후 Provider 를 가져와야 하므로,
    // addPostFrameCallback 메서드를 통해 build 완료를 통지받음.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // 초기화 진행
      _initializer
          .initialize(
            locale: Localizations.localeOf(context),
            onDone: _onDone,
            onServerError: _onServerError
          ).catchError((err) => _onServerError());
    });
  }

  void _onDone() => _router.navigateTo(context, '/');

  void _onServerError() => _router.navigateTo(context, '/error/Server Down');

}
