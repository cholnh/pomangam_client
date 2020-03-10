import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_image.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_like.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_review.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_sub_title.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_title.dart';
import 'package:provider/provider.dart';

class HomeContentsItem extends StatefulWidget {

  static const double paddingValue = 0.0;
  static const double contentsPaddingValue = 10.0;

  final StoreSummary summary;

  HomeContentsItem({Key key, this.summary}): super(key: key);

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

    List<String> imagePaths = List()
      ..add(widget.summary?.storeImageMainPath)
      ..addAll(widget.summary?.storeImageSubPaths);
    double opacity = _isOrderable && _isOpening ? 1 : 0.5;

    return GestureDetector(
      key: widget.key,
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
              heroTag: 'storeImageHero${widget.summary.idx}',
              brandImagePath: '${Endpoint.serverDomain}/${widget.summary.brandImagePath}',
              title: widget.summary.name,
              subTitle: _subTitle(),
              subTitleColor: widget.summary.quantityOrderable <= 5 ? primaryColor : Colors.grey,
              avgStar: widget.summary.avgStar
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            HomeContentsItemImage(
              opacity: opacity,
              height: 250.0,
              imagePaths: imagePaths
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            HomeContentsItemLike(
              opacity: opacity,
              cntLike: widget.summary.cntLike,
              couponType: widget.summary.couponType,
              couponValue: widget.summary.couponValue
            ),
            const Padding(padding: EdgeInsets.only(bottom: 7.0)),
            HomeContentsItemSubTitle(
              opacity: opacity,
              title: widget.summary.name,
              description: widget.summary.description
            ),
            const Padding(padding: EdgeInsets.only(bottom: 7.0)),
            HomeContentsItemReview(
              opacity: opacity,
              cntComment: widget.summary.cntReview
            ),
            const Padding(padding: EdgeInsets.only(bottom: 26.0)),
          ],
        ),
      ),
    );
  }

  void _navigateToStorePage() {
    Provider.of<StoreModel>(context, listen: false)
        .summary = widget.summary;
    _router.navigateTo(context, '/stores/${widget.summary.idx}');
  }

  String _subTitle() {
    return _isOpening
      ? widget.summary.quantityOrderable > 0 && _isOrderable
        ? widget.summary.quantityOrderable <= 5
          ? '마감임박 ${widget.summary.quantityOrderable}개'
          : '주문가능 ${widget.summary.quantityOrderable}개'
        : '주문마감'
      : '${widget.summary.storeSchedule.pauseDescription}';
  }
}
