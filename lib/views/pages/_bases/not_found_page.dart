import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/i18n/messages.dart';
import 'package:pomangam_client/_bases/router/app_router.dart';
import 'package:injector/injector.dart';

class NotFoundPage extends StatelessWidget {
  final AppRouter router = Injector.appInstance.getDependency<AppRouter>();

  NotFoundPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(Messages.notFoundMsg, style: TextStyle(fontSize: 26)),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(Messages.notFoundHomeBtn),
                    color: Theme.of(context).accentColor,
                    onPressed: () => router.navigateTo(context, '/', replace: true),
                  ),
                  RaisedButton(
                    child: Text(Messages.notFoundBackBtn),
                    onPressed: () => router.pop(context),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
