import 'package:dio/dio.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';

class DioCore {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  Dio oauth;
  Dio resource;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ singleton constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  static final DioCore _singleton = DioCore._internal();

  factory DioCore() {
    return _singleton;
  }

  DioCore._internal() {
    initialize();
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  initialize() {
    final BaseOptions options = BaseOptions(
      baseUrl: Endpoint.serverDomain,
      connectTimeout: Endpoint.connectTimeout,
      receiveTimeout: Endpoint.receiveTimeout,
    );

    oauth = Dio(options);
    resource = Dio(options);
  }

  addResourceHeader(Map<String, dynamic> header) {
    resource.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        options.headers.addAll(header);
        return options;
      }
    ));
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}