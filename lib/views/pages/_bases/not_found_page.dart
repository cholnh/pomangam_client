import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/i18n/messages.dart';

class NotFoundPage extends StatelessWidget {

  NotFoundPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                    ),
                    RaisedButton(
                      child: Text(Messages.notFoundBackBtn),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
