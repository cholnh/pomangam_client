import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/store/store_model.dart';

class StoreDescription extends StatelessWidget {

  final StoreModel storeModel;

  StoreDescription({this.storeModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeDescription,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${storeModel.store?.storeInfo?.name ?? ''}', style: TextStyle(fontWeight: FontWeight.w600)),
            Text('${storeModel.store?.storeCategory}', style: TextStyle(color: Colors.black45)),
            Text('${storeModel.store?.storeInfo?.description ?? ''}',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle()
            ),
            storeModel.store?.storeInfo?.subDescription != null
              ? Text('${storeModel.store?.storeInfo?.subDescription ?? ''}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle()
                )
              : Container()
          ],
        ),
      )
    );
  }
}
