import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/key/pmg_key.dart';
import 'package:pomangam_client/domains/tab/tab_menu.dart';
import 'package:pomangam_client/providers/advertisement/advertisement_model.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/providers/order/time/order_time_model.dart';
import 'package:pomangam_client/providers/store/store_summary_model.dart';
import 'package:pomangam_client/providers/tab/tab_model.dart';
import 'package:pomangam_client/views/widgets/_bases/base_app_bar.dart';
import 'package:pomangam_client/views/widgets/_bases/tab_selector.dart';
import 'package:pomangam_client/views/widgets/home/advertisement/home_advertisement_widget.dart';
import 'package:pomangam_client/views/widgets/home/contents/home_contents_bar_widget.dart';
import 'package:pomangam_client/views/widgets/home/contents/home_contents_widget.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_collapsed_widget.dart';
import 'package:pomangam_client/views/widgets/store/slide/store_slide_floating_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PanelController _panelController = PanelController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isPanelShown = false;

  StoreSummaryModel storeSummaryModel;
  int dIdx;
  int oIdx;
  DateTime oDate;

  StreamController _streamController;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    storeSummaryModel = Provider.of<StoreSummaryModel>(context, listen: false);
    _init();
    _streamController = StreamController()
      ..addStream(Stream.periodic(
          Duration(seconds: 20),
              (_) => storeSummaryModel.fetchQuantityOrderable(dIdx: dIdx, oIdx: oIdx, oDate: oDate)));
    _streamSubscription = _streamController.stream.listen(storeSummaryModel.setQuantityOrderable);
  }

  @override
  void deactivate() {
    super.deactivate();
    if(ModalRoute.of(context).isCurrent && Provider.of<TabModel>(context).tab == TabMenu.home) {
      _streamSubscription.resume();
    } else {
      _streamSubscription.pause();
    }
  }

  @override
  void dispose() {
    if(_streamController.isClosed) {
      _streamController.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (_, model, child) {
        bool isShowCart = (model.cart?.items?.length ?? 0) != 0;
        return Material(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Scaffold(
                  appBar: BaseAppBar(),
                  bottomNavigationBar: TabSelector(),
                  body: _body(isShowCart: isShowCart),
                ),
                isShowCart
                ? SlidingUpPanel(
                  controller: _panelController,
                  minHeight: 80.0,
                  maxHeight: 550.0,
                  backdropEnabled: true,
                  renderPanelSheet: false,
                  onPanelOpened: () => _onCartOpen(model),
                  onPanelClosed: () => _onCartClose(model),
                  panel: StoreSlideFloatingPanelWidget(),
                  collapsed: StoreSlideFloatingCollapsedWidget(
                    onSelected: () => _panelController.open(),
                  ),
                  body: Scaffold(
                    appBar: BaseAppBar(),
                    body: _body(isShowCart: isShowCart),
                  ),
                )
                : Container()
              ],
            ),
          ),
        );
      }
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
        key: PmgKeys.deliveryPage,
        slivers: <Widget>[
          HomeAdvertisementWidget(),
          HomeContentsBarWidget(
              onChangedTime: _onChangedTime
          ),
          HomeContentsWidget(),
          SliverToBoxAdapter(
            child: Container(height: isShowCart ? 110.0 : 0.0),
          )
        ],
      ),
    );
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

  void _onChangedTime() {
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _onRefresh() async{
    _refreshController.loadComplete();
    _init();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      await storeSummaryModel.fetch(dIdx: dIdx, oIdx: oIdx, oDate: oDate);
      _refreshController.loadComplete();
    }
  }

  void _init() async {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    AdvertisementModel advertisementModel = Provider.of<AdvertisementModel>(context, listen: false);

    // index
    dIdx = deliverySiteModel.userDeliverySite?.idx;
    oIdx = orderTimeModel.userOrderTime?.idx;
    oDate = orderTimeModel.userOrderDate;

    // store summary fetch
    storeSummaryModel.clear();
    await storeSummaryModel.fetch(
      isForceUpdate: true,
      dIdx: dIdx,
      oIdx: oIdx,
      oDate: oDate
    );

    // SmartRefresher 상태 초기화
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    }

    // advertisement fetch
    advertisementModel
    ..clear()
    ..fetch(dIdx: dIdx);
  }
}
