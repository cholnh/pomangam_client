import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/ui/widget/store/store_brand_image.dart';
import 'package:pomangam_client/ui/widget/store/store_score.dart';
import 'package:provider/provider.dart';

class StoreHeader extends StatelessWidget {

  final int sIdx;

  StoreHeader({this.sIdx});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeHeader,
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 7.0, bottom: 15.0),
        child: Consumer<StoreModel>(
          builder: (_, model, child) {
            return Row(
              children: <Widget>[
                StoreBrandImage(
                    sIdx: sIdx,
                    brandImagePath: '${Endpoint.serverDomain}/${model.summary.brandImagePath}'
                ),
                Expanded(
                  child: StoreScore(
                    avgStar: model.summary.avgStar,
                    cntLike: model.summary.cntLike,
                    cntComment: model.summary.cntComment
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
