import 'package:flutter/material.dart';

abstract class NetworkService {
  Future initialize();
  Future get({
    @required String url
  });
  Future post({
    @required String url,
    dynamic data
  });
  Future patch({
    @required String url,
    dynamic data
  });
  @deprecated
  Future put({
    @required String url,
    dynamic data
  });
  Future delete({
    @required String url
  });
}