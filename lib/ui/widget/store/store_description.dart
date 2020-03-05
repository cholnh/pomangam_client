import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:provider/provider.dart';

class StoreDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeDescription,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
        alignment: Alignment.centerLeft,
        child: Consumer<StoreModel>(
          builder: (_, model, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${model.store?.storeInfo?.name ?? ''}', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('${model.store?.storeCategory}', style: TextStyle(color: Colors.black45)),
                Text('${model.store?.storeInfo?.description ?? ''}',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle()
                ),
                model.store?.storeInfo?.subDescription != null
                  ? Text('${model.store?.storeInfo?.subDescription ?? ''}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle()
                    )
                  : Container()
              ],
            );
          }
        ),
      )
    );
  }
}
