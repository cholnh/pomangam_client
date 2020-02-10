import 'package:flutter/material.dart';

abstract class NetworkService {
  Future initialize();
  Future get({
    @required String url
  });
  Future post({
    @required String url,
    Map jsonData
  });
  Future patch({
    @required String url,
    Map jsonData
  });
  @deprecated
  Future put({
    @required String url,
    Map jsonData
  });
  Future delete({
    @required String url
  });
}