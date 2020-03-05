import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/product/product_summary_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/provider/store/store_product_category_model.dart';
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

  ProductSummaryModel _productSummaryModel;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  int _dIdx;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _dIdx = Provider.of<DeliverySiteModel>(context, listen: false)
      .userDeliverySite?.idx;
    Provider.of<StoreProductCategoryModel>(context, listen: false)
      ..idxSelectedCategory = 0
      ..idxProductCategory = 0;
    Provider.of<StoreModel>(context, listen: false)
      ..isStoreFetched = false
      ..fetch(dIdx: _dIdx, sIdx: widget.sIdx);
    _productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false);
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
              StoreHeader(sIdx: widget.sIdx), // desc
              StoreDescription(),
              StoreCenterButton(),
              StoreStory(),
              StoreProductCategory(
                dIdx: _dIdx,
                sIdx: widget.sIdx,
                productCategories: model?.store?.productCategories
              ),
              StoreProduct()
            ],
            controller: _scrollController,
          )
        );
      }
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      int cIdx = Provider.of<StoreProductCategoryModel>(context, listen: false)
          .idxProductCategory;
      _productSummaryModel.fetch(dIdx: _dIdx, sIdx: widget.sIdx, cIdx: cIdx);
    }
  }
}
