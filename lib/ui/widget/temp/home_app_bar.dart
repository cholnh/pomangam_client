import 'package:flutter/material.dart';
import 'package:pomangam_client/common/i18n/messages.dart';
import 'package:pomangam_client/common/network/domain/sign_state.dart';
import 'package:pomangam_client/common/network/provider/user_model.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends AppBar {
  HomeAppBar() : super(
    centerTitle: false,
    automaticallyImplyLeading: false,
    title :InkWell(
      child: Row(
        children: <Widget>[
          //Icon(Icons.calendar_today),
          Padding(padding: EdgeInsets.only(right: 5)),
          Text(Messages.appName, style: TextStyle(fontSize: 20))
        ],
      ),
      onTap: () => print('tab!'),
    ),
    actions: <Widget>[
      Consumer<UserModel>(
        builder: (_, model, child) {
          if(model.signState == SignState.signedIn) {
            return Container(
              margin: EdgeInsets.all(20),
              child: Text('${model.userInfo.nickname}'),
            );
          }
          return Container();
        },
      ),
    ],
  );
}
