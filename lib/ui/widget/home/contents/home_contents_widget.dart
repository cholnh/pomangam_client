import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_widget.dart';
import 'package:provider/provider.dart';

class HomeContentsWidget extends StatelessWidget {

  HomeContentsWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreSummaryModel>(
      builder: (_, model, child) {
        if(model.stores.length == 0) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: model.isFetching
                  ? CupertinoActivityIndicator()
                  : Text('주문가능한 업체가 없습니다...', style: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            ),
          );
        }
        return SliverList(
          key: PmgKeys.deliveryContents,
          delegate: SliverChildBuilderDelegate((context, index) {
            return index >= model.stores.length
              ? Container()
              : HomeContentsItemWidget(
                  key: PmgKeys.homeContentsItem(model.stores[index].idx),
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
