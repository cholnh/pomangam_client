import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/ui/widget/delivery/delivery_contents_item.dart';
import 'package:pomangam_client/ui/widget/temp/todo_bottom_loader.dart';
import 'package:provider/provider.dart';

class DeliveryContents extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    StoreSummaryModel _storeModel = Provider.of<StoreSummaryModel>(context);
    return SliverList(
      key: PmgKeys.deliveryContents,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return index >= _storeModel.stores.length
            ? BottomLoader()
            : DeliveryContentsItem(
                store: _storeModel.stores[index],
          );
        },
        childCount: _storeModel.hasReachedMax
            ? _storeModel.stores.length
            : _storeModel.stores.length + 1
      ),
    );
  }
}
