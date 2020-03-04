import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/ui/widget/store/store_app_bar.dart';
import 'package:pomangam_client/ui/widget/store/store_center_button.dart';
import 'package:pomangam_client/ui/widget/store/store_description.dart';
import 'package:pomangam_client/ui/widget/store/store_header.dart';
import 'package:pomangam_client/ui/widget/store/store_product.dart';
import 'package:pomangam_client/ui/widget/store/store_product_category.dart';
import 'package:pomangam_client/ui/widget/store/store_story.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {

  final int sIdx;

  StorePage({this.sIdx});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  StoreModel storeModel;

  @override
  void initState() {
    super.initState();
    int dIdx = Provider.of<DeliverySiteModel>(context, listen: false)
        .userDeliverySite?.idx;
    storeModel = Provider.of<StoreModel>(context, listen: false)
      ..isStoreFetched = false
      ..fetch(dIdx: dIdx, sIdx: widget.sIdx);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreModel>(
      builder: (_, model, child) {
        return Scaffold(
          appBar: StoreAppBar(
            context,
            title: '${model.store?.storeInfo?.name ?? ''}',
          ),
          body: CustomScrollView(
            key: PmgKeys.storePage,
            slivers: <Widget>[
              StoreHeader(sIdx: widget.sIdx, storeModel: model), // desc
              StoreDescription(storeModel: model),
              StoreCenterButton(storeModel: model),
              StoreStory(storeModel: model),
              StoreProductCategory(storeModel: model),
              StoreProduct(storeModel: model)
            ],
          )
        );
      }
    );
  }
}
