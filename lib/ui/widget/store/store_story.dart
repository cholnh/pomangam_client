import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';

class StoreStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeStory,
      child: Column(
        children: <Widget>[
          Container(),
          Padding(padding: EdgeInsets.only(top: 20.0), child: Divider(height: 0.5))
        ],
      ),
    );
  }
}
