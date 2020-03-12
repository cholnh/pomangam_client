import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/domain/tab/tab_menu.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/provider/tab/tab_model.dart';
import 'package:pomangam_client/ui/widget/home/advertisement/home_advertisement_widget.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_widget.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

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
        ],
      ),
    );
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
  }
}
