import 'package:flutter/material.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';
import 'package:pomangam_client/common/network/service/network_service.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:injector/injector.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final AppRouter router = Injector.appInstance.getDependency<AppRouter>();
  String imgSrc = 'assets/logo3.gif';
  int imgDelay = 3000;
  bool isNetworkServiceDone = false;
  bool isImageDrawDone = false;

  @override
  void initState() {
    super.initState();

    _readyNetworkService(); // Network Service 준비
    _readyLoadingImage();   // Loading Image 준비
  }

  _readyNetworkService() async {
    NetworkService _networkService
      = Injector.appInstance.getDependency<NetworkService>();
    await _networkService.initialize(
      networkErrorHandler: () =>
        router.navigateTo(context, '/error/Server Down'));

    isNetworkServiceDone = true;
    next(to: '/');
  }

  _readyLoadingImage() async {
    await Future.delayed(
      Duration(milliseconds: imgDelay));

    isImageDrawDone = true;
    next(to: '/');
  }

  void next({String to}) {
    if(isNetworkServiceDone && isImageDrawDone) {
      router.navigateTo(context, to);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage(imgSrc),
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
}
