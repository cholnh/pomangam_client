import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/ui/widget/delivery/delivery_contents_item.dart';
import 'package:pomangam_client/ui/widget/delivery/bottom_loader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryContents extends StatelessWidget {

  final int didx;

  DeliveryContents({this.didx});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, model, child) {
        return SliverList(
          key: PmgKeys.deliveryContents,
          delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return index >= model.stores.length
                    ? BottomLoader()
                    : DeliveryContentsItem(
                        didx: didx,
                        summary: model.stores[index]
                      );
              },
              childCount: model.hasReachedMax
                  ? model.stores.length
                  : model.stores.length + 1
          ),
        );
      }
    );
  }
}
