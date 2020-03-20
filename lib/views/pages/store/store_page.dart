import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/key/pmg_key.dart';
import 'package:pomangam_client/_bases/router/app_router.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:pomangam_client/providers/product/product_summary_model.dart';
import 'package:pomangam_client/providers/store/store_model.dart';
import 'package:pomangam_client/providers/store/store_product_category_model.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_widget.dart';
import 'package:pomangam_client/views/widgets/store/store_app_bar.dart';
import 'package:pomangam_client/views/widgets/store/store_center_button_widget.dart';
import 'package:pomangam_client/views/widgets/store/store_description_widget.dart';
import 'package:pomangam_client/views/widgets/store/store_header_widget.dart';
import 'package:pomangam_client/views/widgets/store/store_product_widget.dart';
import 'package:pomangam_client/views/widgets/store/store_product_category_widget.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_collapsed_widget.dart';
import 'package:pomangam_client/views/widgets/store/store_story_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StorePage extends StatefulWidget {

  final int sIdx;

  StorePage({this.sIdx});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  final PanelController _panelController = PanelController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isPanelShown = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StoreAppBar(context),
      body: SafeArea(
        child: Consumer<CartModel>(
          builder: (_, model, child) {
            bool isShowCart = (model.cart?.items?.length ?? 0) != 0;

            return Stack(
              children: <Widget>[
                _body(isShowCart: isShowCart),
                isShowCart
                ? SlidingUpPanel(
                  controller: _panelController,
                  minHeight: 80.0,
                  backdropEnabled: true,
                  renderPanelSheet: false,
                  onPanelOpened: () => _onCartOpen(model),
                  onPanelClosed: () => _onCartClose(model),
                  panel: StoreSlideFloatingPanelWidget(),
                  collapsed: StoreSlideFloatingCollapsedWidget(
                    onSelected: () => _panelController.open(),
                  )
                )
                : Container()
              ],
            );
          }
        ),
      )
    );
  }

  Widget _body({bool isShowCart = false}) {
    return SmartRefresher(
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
            StoreHeaderWidget(sIdx: widget.sIdx), // desc
            StoreDescriptionWidget(),
            StoreCenterButtonWidget(),
            StoreStoryWidget(),
            StoreProductCategoryWidget(
                sIdx: widget.sIdx,
                onChangedCategory: _onChangedCategory
            ),
            StoreProductWidget(),
            SliverToBoxAdapter(
              child: Container(height: isShowCart ? 55.0 : 0.0),
            )
          ],
        )
    );
  }

  void _init({bool isBuild = false}) async {
    StoreModel storeModel = Provider.of<StoreModel>(context, listen: false);
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    StoreProductCategoryModel categoryModel = Provider.of<StoreProductCategoryModel>(context, listen: false);
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false);

    // delivery site index
    int dIdx = deliverySiteModel.userDeliverySite?.idx;

    // store category
    if(isBuild) {
      categoryModel.clearWithNotifier();
    } else {
      categoryModel.clear();
    }

    // store fetch
    storeModel
    ..store = null
    ..isStoreFetched = false
    ..isStoreDescriptionOpened = false
    ..fetch(dIdx: dIdx, sIdx: widget.sIdx);

    // products fetch
    productSummaryModel.clear();
    productSummaryModel.fetch(
      isForceUpdate: true,
      dIdx: dIdx,
      sIdx: widget.sIdx
    ).then((res) {
      // SmartRefresher 상태 초기화
      if(productSummaryModel.hasReachedMax) {
        _refreshController.loadNoData();
      }
    });

    isPanelShown = false;
  }

  void _onCartOpen(CartModel cartModel) {
    if(isPanelShown) return;
    isPanelShown = true;
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);

    cartModel.updateOrderableStore(
      dIdx: deliverySiteModel.userDeliverySite?.idx,
      oIdx: orderTimeModel.userOrderTime?.idx,
      oDate: orderTimeModel.userOrderDate
    );
  }

  void _onCartClose(CartModel cartModel) {
    isPanelShown = false;
    cartModel.changeIsUpdatedOrderableStore(false);
  }

  void _onChangedCategory() {
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false);
    if(productSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _onBottomButtonSelected() {
    Injector.appInstance.getDependency<AppRouter>().navigateTo(context, '/carts');
  }

  void _onRefresh() async {
    _refreshController.loadComplete();
    _init(isBuild: true);
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
