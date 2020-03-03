import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/domain/store/store.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_image.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_like.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_star.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_sub_title.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_title.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeContentsItem extends StatefulWidget {
  static const double paddingValue = 0.0;
  static const double contentsPaddingValue = 10.0;

  final StoreSummary summary;

  HomeContentsItem({this.summary});

  @override
  _HomeContentsItemState createState() => _HomeContentsItemState();
}

class _HomeContentsItemState extends State<HomeContentsItem> {

  final AppRouter _router = Injector.appInstance.getDependency<AppRouter>();
  bool _isOrderable;
  bool _isOpening;

  @override
  void initState() {
    super.initState();
    DateTime userOrderDate = Provider.of<OrderTimeModel>(context, listen: false)
        .userOrderDate;
    bool isNextDay = userOrderDate?.isAfter(DateTime.now());
    _isOrderable = isNextDay || widget.summary.isOrderable();
    _isOpening = isNextDay || widget.summary.storeSchedule.isOpening;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _isOrderable && _isOpening
          ? _navigateToStorePage()
          : {},
      child: Container(
        padding: const EdgeInsets.only(
            left: HomeContentsItem.paddingValue,
            right: HomeContentsItem.paddingValue
        ),
        child: Column(
          children: <Widget>[
            const Divider(height: 0.1),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            HomeContentsItemTitle(
              isOpening: _isOpening,
              isOrderable: _isOrderable,
              summary: widget.summary
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            HomeContentsItemImage(
              isOpening: _isOpening,
              isOrderable: _isOrderable,
              summary: widget.summary
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            HomeContentsItemLike(
                isOpening: _isOpening,
                isOrderable: _isOrderable,
                summary: widget.summary
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5.0)),
            HomeContentsItemStar(
                isOpening: _isOpening,
                isOrderable: _isOrderable,
                summary: widget.summary
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5.0)),
            HomeContentsItemSubTitle(
                isOpening: _isOpening,
                isOrderable: _isOrderable,
                summary: widget.summary
            ),
            const Padding(padding: EdgeInsets.only(bottom: 26.0)),
          ],
        ),
      ),
    );
  }

  void _navigateToStorePage() {
    Provider.of<StoreModel>(context, listen: false)
        .brandImagePath = widget.summary.brandImagePath;
    _router.navigateTo(context, '/stores/${widget.summary.idx}');
  }
}
