import 'package:flutter/material.dart';
import 'package:pomangam_client/views/widgets/_bases/tab_selector.dart';

class OrderInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('뒤로가기');
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: TabSelector(),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('order info page'),
            )
        ),
      ),
    );
  }
}
