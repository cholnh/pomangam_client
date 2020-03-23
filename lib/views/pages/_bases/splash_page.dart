import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/i18n/i18n.dart';
import 'package:pomangam_client/_bases/router/app_router.dart';
import 'package:pomangam_client/_bases/initalizer/initializer.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(332 / 360),
              child: Image(
                image: const AssetImage('assets/logo_transparant.png'),
                width: 150,
                height: 150,
              ),
            ),
            alignment: Alignment.center,
          ),
          Container(
            child: TypewriterAnimatedTextKit(
              text: ['${Messages.companyName}'],
              textStyle: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: backgroundColor
              ),
              textAlign: TextAlign.left,
              speed: Duration(milliseconds: 300),
              alignment: AlignmentDirectional.topStart,
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
      _initializer
        .initialize(
          context: context,
          onDone: _onDone,
          onServerError: _onServerError,
          deliverySiteNotIssuedHandler: _deliverySiteNotIssuedHandler
        ).catchError((err) => _onServerError());
    });
  }

  void _onDone() => _router.navigateTo(context, '/', clearStack: true);

  void _onServerError() => _router.navigateTo(context, '/error/Server Down', clearStack: true);

  void _deliverySiteNotIssuedHandler() =>  _router.navigateTo(context, '/dsites', clearStack: true);

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
