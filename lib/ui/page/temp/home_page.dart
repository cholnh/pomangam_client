import 'package:flutter/material.dart';
import 'package:pomangam_client/common/network/domain/sign_state.dart';
import 'package:pomangam_client/common/network/provider/user_model.dart';
import 'package:pomangam_client/domain/tab/tab_menu.dart';
import 'package:pomangam_client/provider/tab/tab_model.dart';
import 'package:pomangam_client/provider/temp/todo_model.dart';
import 'package:pomangam_client/ui/page/more/more_page.dart';
import 'package:pomangam_client/ui/page/temp/more_signed_page.dart';
import 'package:pomangam_client/ui/page/temp/stat_page.dart';
import 'package:pomangam_client/ui/page/temp/todo_page.dart';
import 'package:pomangam_client/ui/widget/temp/home_app_bar.dart';
import 'package:pomangam_client/ui/widget/temp/home_fab.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: TabMenu.values.length);
    _tabController.addListener(() {
      Provider.of<TabModel>(context, listen: false).change(
        TabMenu.values[_tabController.index]
      );
    });
    Provider.of<TodoModel>(context, listen: false).fetch();

  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return WillPopScope(
      onWillPop: () => Future.value(false), // 뒤로가기 방지
      child: DefaultTabController(
        length: TabMenu.values.length,
        child:  Scaffold(
          appBar: HomeAppBar(),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              TodoPage(),
              StatPage(),
              userModel.signState == SignState.signedIn
                ? MoreSignedPage()
                : MorePage()
            ],
          ),
          floatingActionButton: HomeFab(),
          //bottomNavigationBar: HomeBottomNavigationBar(tabController: _tabController)
        )
      )
    );
  }
}
