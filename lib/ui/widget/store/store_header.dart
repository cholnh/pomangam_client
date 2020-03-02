import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/ui/widget/store/store_brand_image.dart';
import 'package:pomangam_client/ui/widget/store/store_score.dart';

class StoreHeader extends StatelessWidget {

  final int sIdx;
  final String brandImagePath;

  StoreHeader({this.sIdx, this.brandImagePath});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeHeader,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 10.0, bottom: 20.0),
        child: Row(
          children: <Widget>[
            StoreBrandImage(
                sIdx: sIdx,
                brandImagePath: brandImagePath
            ),
            Expanded(
              child: StoreScore(),
            )
          ],
        ),
      ),
    );
  }
}
