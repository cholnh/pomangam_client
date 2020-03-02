import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/ui/widget/home/home_advertisement.dart';
import 'package:pomangam_client/ui/widget/home/home_contents.dart';
import 'package:pomangam_client/ui/widget/home/home_contents_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  int dIdx;
  int oIdx;
  DateTime oDate;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);

    dIdx = deliverySiteModel.userDeliverySite?.idx;
    oIdx = orderTimeModel.userOrderTime?.idx;
    oDate = orderTimeModel.userOrderDate;

    Provider.of<StoreSummaryModel>(context, listen: false).fetch(dIdx: dIdx, oIdx: oIdx, oDate: oDate);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PmgKeys.deliveryPage,
      slivers: <Widget>[
        HomeAdvertisement(),
        HomeContentsBar(),
        HomeContents(),
      ],
      controller: _scrollController,
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      Provider.of<StoreSummaryModel>(context, listen: false).fetch(dIdx: dIdx, oIdx: oIdx, oDate: oDate);
    }
  }
}
