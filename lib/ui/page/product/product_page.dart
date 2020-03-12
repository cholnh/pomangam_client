import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/product/product_type.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:pomangam_client/provider/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/ui/widget/product/custom/product_custom_contents_widget.dart';
import 'package:pomangam_client/ui/widget/product/custom/product_custom_sub_widget.dart';
import 'package:pomangam_client/ui/widget/product/product_app_bar.dart';
import 'package:pomangam_client/ui/widget/product/product_contents_widget.dart';
import 'package:pomangam_client/ui/widget/product/product_sub_category_widget.dart';
import 'package:pomangam_client/ui/widget/product/product_sub_widget.dart';
import 'package:pomangam_client/ui/widget/store/store_bottom_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductPage extends StatefulWidget {

  final int pIdx;

  ProductPage({this.pIdx});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBar(context),
      bottomNavigationBar:  StoreBottomBarWidget(
        centerText: '카트에 추가',
        rightText: '3,500원',
      ),
      body: SmartRefresher(
          physics: BouncingScrollPhysics(),
          enablePullDown: true,
          header: WaterDropMaterialHeader(
            color: primaryColor,
            backgroundColor: backgroundColor,
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: Consumer<ProductModel>(
            builder: (_, model, child) {
              ProductType type = model.product?.productType;
              if(type == null) {
                return CupertinoActivityIndicator();
              } else if(type != ProductType.NORMAL) {
                return Column(
                  children: <Widget>[
                    ProductCustomContentsWidget(productType: type),
                    Divider(height: 0.5),
                    Flexible(
                      child: CustomScrollView(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        slivers: <Widget>[
                          ProductCustomSubWidget()
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    ProductContentsWidget(),
                    ProductSubCategoryWidget(pIdx: widget.pIdx, onCategoryChanged: _onCategoryChanged),
                    ProductSubWidget()
                  ],
                );
              }
            },
          )
      )
    );
  }

  void _init({bool isBuild = false}) async {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    StoreModel storeModel = Provider.of<StoreModel>(context, listen: false);
    ProductModel productModel = Provider.of<ProductModel>(context, listen: false);
    ProductSubCategoryModel subCategoryModel = Provider.of<ProductSubCategoryModel>(context, listen: false);

    // sub category
    if(isBuild) {
      subCategoryModel.clearWithNotifier();
    } else {
      subCategoryModel.clear();
    }

    // product fetch
    productModel
    ..product = null
    ..isProductFetched = false
    ..idxProductSubCategory = 0
    ..fetch(
        dIdx: deliverySiteModel.userDeliverySite?.idx,
        sIdx: storeModel.store.idx,
        pIdx: widget.pIdx
    );
  }

  void _onRefresh() async {
    _init(isBuild: true);
    _refreshController.refreshCompleted();
  }

  void _onCategoryChanged(double position) {
    _scrollController.animateTo(position, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

//  Widget _contentsWidget(ProductType type) {
//    switch(type) {
//      case ProductType.CUSTOMIZING_2:
//        return ;
//      case ProductType.CUSTOMIZING_3:
//        return ProductContentsWidget();
//      case ProductType.CUSTOMIZING_4:
//        return ProductContentsWidget();
//      case ProductType.CUSTOMIZING_5:
//        return ProductContentsWidget();
//      case ProductType.CUSTOMIZING_6:
//        return ProductContentsWidget();
//      default:
//        return ProductContentsWidget();
//    }
//  }
}
