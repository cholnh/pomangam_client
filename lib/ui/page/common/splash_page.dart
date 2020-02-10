import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/provider/common/initializer_model.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final AppRouter _router = Injector.appInstance.getDependency<AppRouter>();
  String _imgSrc = 'assets/logo3.gif';
  int _imgDelay = 3000;
  bool _isNetworkServiceDone = false;
  bool _isImageDrawDone = false;


  @override
  void initState() {
    super.initState();
    _readyInitialize(); // 초기화 준비
    _readyLoadingImage(); // Loading Image 준비
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
              image: AssetImage(_imgSrc),
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
      Provider.of<InitializerModel>(context, listen: false)
          .initialize(locale: Localizations.localeOf(context))
          .catchError((err) => _router.navigateTo(context, '/error/Server Down'));
    });
    _isNetworkServiceDone = true;
    _next(to: '/');
  }

  _readyLoadingImage() async {
    await Future.delayed(
        Duration(milliseconds: _imgDelay));
    _isImageDrawDone = true;
    _next(to: '/');
  }

  void _next({String to}) {
    if(_isNetworkServiceDone && _isImageDrawDone) {
      _router.navigateTo(context, to);
    }
  }
}
