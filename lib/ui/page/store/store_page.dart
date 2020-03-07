import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
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
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StorePage extends StatefulWidget {

  final int sIdx;

  StorePage({this.sIdx});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _init();
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
          body: SmartRefresher(
            physics: BouncingScrollPhysics(),
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropMaterialHeader(
              color: primaryColor,
              backgroundColor: backgroundColor,
            ),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              noDataText: '',
              canLoadingText: '',
              loadingText: '',
              loadingIcon: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: CupertinoActivityIndicator(),
              ),
              idleText: '',
              idleIcon: Container(),
              failedText: '탭하여 다시 시도',
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: CustomScrollView(
              key: PmgKeys.storePage,
              slivers: <Widget>[
                StoreHeader(sIdx: widget.sIdx), // desc
                StoreDescription(),
                StoreCenterButton(),
                StoreStory(),
                StoreProductCategory(
                  sIdx: widget.sIdx,
                  productCategories: model?.store?.productCategories,
                  onChangedCategory: _onChangedCategory
                ),
                StoreProduct()
              ],
            )
          )
        );
      }
    );
  }

  void _init() async {
    StoreModel storeModel = Provider.of<StoreModel>(context, listen: false);
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    StoreProductCategoryModel categoryModel = Provider.of<StoreProductCategoryModel>(context, listen: false);
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false);

    // delivery site index
    int dIdx = deliverySiteModel.userDeliverySite?.idx;

    // store category
    categoryModel
      ..idxSelectedCategory = 0
      ..idxProductCategory = 0;

    // store fetch
    storeModel
      ..isStoreFetched = false
      ..isStoreDescriptionOpened = false
      ..fetch(dIdx: dIdx, sIdx: widget.sIdx);

    // products fetch
    productSummaryModel.clear();
    await productSummaryModel.fetch(
          isForceUpdate: true,
          dIdx: dIdx,
          sIdx: widget.sIdx
    );

    // SmartRefresher 상태 초기화
    if(productSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    }
  }

  void _onChangedCategory() {
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false);
    if(productSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _onRefresh() async {
    _refreshController.loadComplete();
    _init();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false);

    if(productSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
      int dIdx = deliverySiteModel.userDeliverySite?.idx;
      int cIdx = Provider.of<StoreProductCategoryModel>(context, listen: false)
          .idxProductCategory;


      await productSummaryModel.fetch(
        isForceUpdate: true,
        dIdx: dIdx,
        sIdx: widget.sIdx,
        cIdx: cIdx
      );
      _refreshController.loadComplete();
    }
  }
}
