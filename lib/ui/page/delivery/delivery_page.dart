import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/delivery/delivery_site_model.dart';
import 'package:pomangam_client/provider/store/store_summary_model.dart';
import 'package:pomangam_client/ui/widget/delivery/delivery_advertisement.dart';
import 'package:pomangam_client/ui/widget/delivery/delivery_contents.dart';
import 'package:pomangam_client/ui/widget/delivery/delivery_contents_bar.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  int didx;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Provider.of<StoreSummaryModel>(context, listen: false).fetch();
    didx = Provider.of<DeliverySiteModel>(context, listen: false).userDeliverySite?.idx;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PmgKeys.deliveryPage,
      slivers: <Widget>[
        DeliveryAdvertisement(),
        DeliveryContentsBar(),
        DeliveryContents(didx: didx),
      ],
      controller: _scrollController,
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      Provider.of<StoreSummaryModel>(context, listen: false).fetch();
    }
  }
}
