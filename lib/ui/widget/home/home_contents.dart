import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/ui/widget/home/home_contents_item.dart';
import 'package:pomangam_client/ui/widget/home/home_bottom_loader.dart';
import 'package:provider/provider.dart';

class HomeContents extends StatelessWidget {

  HomeContents();

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreSummaryModel>(
      builder: (_, model, child) {
        if(model.stores.length == 0) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('주문가능한 업체가 없습니다...', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
              );
            }, childCount: 1)
          );
        }
        return SliverList(
          key: PmgKeys.deliveryContents,
          delegate: SliverChildBuilderDelegate((context, index) {
            return index >= model.stores.length
              ? HomeBottomLoader()
              : HomeContentsItem(summary: model.stores[index]);
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
