import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/common/initalizer/initializer.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(332 / 360),
              child: Image(
                image: const AssetImage('assets/logot.png'),
                width: 150,
                height: 150,
              ),
            ),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(
              Messages.companyName,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: backgroundColor),
            ),
            margin: const EdgeInsets.only(bottom: 50),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
      backgroundColor: primaryColor,
    );
  }

  _readyInitialize() async {
    // widget build 가 모두 완료된 후 Provider 를 가져와야 하므로,
    // addPostFrameCallback 메서드를 통해 build 완료를 통지받음.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await clearPrefs(); // for test
      await _initializer.signIn(phoneNumber: '01064784895', password: '1234'); // for test

      // 초기화 진행
      _initializer
          .initialize(
            context: context,
            onDone: _onDone,
            onServerError: _onServerError
          ).catchError((err) => _onServerError());

      await printPrefs();  // for test
    });
  }

  void _onDone() => _router.navigateTo(context, '/');

  void _onServerError() => _router.navigateTo(context, '/error/Server Down');

  @visibleForTesting
  Future<void> clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @visibleForTesting
  Future<void> printPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(String key in prefs.getKeys()) {
      print('key: $key / value: ${prefs.get(key)}');
    }
  }
}
