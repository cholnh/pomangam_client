import 'package:flutter/material.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/domain/tab/tab_menu.dart';
import 'package:pomangam_client/provider/tab/tab_model.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class HomeFab extends StatelessWidget {

  final AppRouter router = Injector.appInstance.getDependency<AppRouter>();

  @override
  Widget build(BuildContext context) {
    if(Provider.of<TabModel>(context).tab == TabMenu.home) {
      return FloatingActionButton(
        onPressed: () => router.navigateTo(context, '/asd'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      );
    }
    return Container();
  }


}
