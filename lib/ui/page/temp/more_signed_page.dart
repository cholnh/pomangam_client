import 'package:flutter/material.dart';
import 'package:pomangam_client/common/network/provider/user_model.dart';
import 'package:provider/provider.dart';

class MoreSignedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () => Provider.of<UserModel>(context, listen: false).signOut(),
              child: Text('Sign Out'),
            ),
          ),
          Consumer<UserModel>(
            builder: (_, model, child) {
              return Text('${model.signState}');
            },
          )
        ]
      )
    );
  }
}
