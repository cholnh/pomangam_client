import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/domains/product/product_type.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:pomangam_client/providers/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client/providers/store/store_model.dart';
import 'package:pomangam_client/views/widgets/product/custom/product_custom_contents_widget.dart';
import 'package:pomangam_client/views/widgets/product/custom/product_custom_image_widget.dart';
import 'package:pomangam_client/views/widgets/product/custom/product_custom_sub_widget.dart';
import 'package:pomangam_client/views/widgets/product/product_app_bar.dart';
import 'package:pomangam_client/views/widgets/product/product_contents_widget.dart';
import 'package:pomangam_client/views/widgets/product/slide/product_slide_floating_collapsed_widget.dart';
import 'package:pomangam_client/views/widgets/product/slide/product_slide_floating_panel_widget.dart';
import 'package:pomangam_client/views/widgets/product/product_sub_category_widget.dart';
import 'package:pomangam_client/views/widgets/product/product_sub_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductPage extends StatefulWidget {

  final int pIdx;

  ProductPage({this.pIdx});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final PanelController _panelController = PanelController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final GlobalKey keyProductSubCategory = GlobalKey();

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Stack(
            children: <Widget>[
              WillPopScope(
                onWillPop: () async {
                  if(_panelController.isPanelOpen) {
                    _panelController.close();
                    return Future.value(false);
                  } else {
                    return Future.value(true);
                  }
                },
                child: Scaffold(
                  appBar: ProductAppBar(context),
                  body: SmartRefresher(
                    physics: BouncingScrollPhysics(),
                    enablePullDown: true,
                    header: WaterDropMaterialHeader(
                      color: primaryColor,
                      backgroundColor: backgroundColor,
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: _body(),
                  ),
                ),
              ),
              SlidingUpPanel(
                controller: _panelController,
                minHeight: 80.0,
                maxHeight: 250.0,
                backdropEnabled: true,
                renderPanelSheet: false,
                panel: ProductSlideFloatingPanelWidget(),
                collapsed: ProductSlideFloatingCollapsedWidget(
                  onSelected: () => _panelController.open(),
                ),
                onPanelClosed: () => FocusScope.of(context).unfocus(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    ProductType type = Provider.of<ProductModel>(context).product?.productType;
    if(type == null) {
      return CupertinoActivityIndicator();
    } else if(type != ProductType.NORMAL) {
      return Column(
        children: <Widget>[
          ProductCustomImageWidget(
              productType: type,
              onSelected: _onCategoryItemSelected
          ),
          Divider(height: 0.5),
          Flexible(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                ProductCustomContentsWidget(),
                ProductSubCategoryWidget(
                  keyProductSubCategory: keyProductSubCategory,
                  pIdx: widget.pIdx,
                  onSelected: _onCategoryItemSelected,
                ),
                ProductCustomSubWidget(),
                SliverToBoxAdapter(
                  child: Container(height: 55.0),
                )
              ],
            ),
          ),
        ],
      );
    } else if(type == ProductType.NORMAL){
      return CustomScrollView(
        slivers: <Widget>[
          ProductContentsWidget(),
          ProductSubCategoryWidget(
            keyProductSubCategory: keyProductSubCategory,
            pIdx: widget.pIdx,
            onSelected: _onCategoryItemSelected,
          ),
          ProductSubWidget(),
          SliverToBoxAdapter(
            child: Container(height: 55.0),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  void _onCategoryItemSelected(int idxSelected, int idxProductSubCategory) {
    Provider.of<ProductSubCategoryModel>(context, listen: false).changeIdxSelectedCategory(idxSelected);
    Provider.of<ProductModel>(context, listen: false).changeIdxProductSubCategory(idxProductSubCategory == null ? 0 : idxProductSubCategory);
    Scrollable.ensureVisible(keyProductSubCategory.currentContext, duration: Duration(milliseconds: 500), curve: Curves.ease);
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
    ..quantity = 1
    ..isProductFetched = false
    ..idxProductSubCategory = 0
    ..isUserRecentRequirement = false
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
}