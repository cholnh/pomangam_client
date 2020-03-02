import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/domain/store/store.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:pomangam_client/provider/order/time/order_time_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
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
  bool isOrderable;
  bool isOpening;

  @override
  void initState() {
    DateTime userOrderDate = Provider.of<OrderTimeModel>(context, listen: false).userOrderDate;
    bool isNextDay = userOrderDate?.isAfter(DateTime.now());
    isOrderable = isNextDay || widget.summary.isOrderable();
    isOpening = isNextDay || widget.summary.storeSchedule.isOpening;
  }

  void navigateToStorePage() {
    Provider.of<StoreModel>(context, listen: false).brandImagePath = widget.summary.brandImagePath;
    _router.navigateTo(context, '/stores/${widget.summary.idx}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isOrderable && isOpening
          ? navigateToStorePage()
          : {},
      child: Container(
        padding: const EdgeInsets.only(left: HomeContentsItem.paddingValue, right: HomeContentsItem.paddingValue),
        child: Column(
          children: <Widget>[
            Divider(height: 0.1),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            // 타이틀
            Padding(
              padding: const EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Hero(
                          tag: 'storeImageHero${widget.summary.idx}',
                          child: Container(
                              child: CircleAvatar(
                                  child: Image.network(
                                    '${Endpoint.serverDomain}${widget.summary.brandImagePath}',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.fill,
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.white
                              ),
                              width: 30.0,
                              height: 30.0,
                              padding: const EdgeInsets.all(0.5),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.circle,
                              )
                          )
                      ),
                      Padding(padding: EdgeInsets.only(right: 10.0)),
                      Text(
                          '${widget.summary.name}',
                          style: TextStyle()
                      ),
                    ],
                  ),
                  Text(
                      isOpening
                          ? isOrderable
                          ? widget.summary.quantityOrderable <= 5
                          ? '마감임박 ${widget.summary.quantityOrderable}개'
                          : '주문가능 ${widget.summary.quantityOrderable}개'
                          : '주문마감'
                          : '${widget.summary.storeSchedule.pauseDescription}',
                      style: TextStyle(
                          color: isOpening || widget.summary.quantityOrderable <= 5 ? Colors.grey : Colors.red,
                          fontSize: 13.0)
                  )
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),

            // 이미지
            Stack(
              children: <Widget>[
                Opacity(
                  opacity: isOrderable && isOpening
                      ? 1
                      : 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.3)
                    ),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: '${Endpoint.serverDomain}${widget.summary.storeImageMainPath}',
                      width: MediaQuery.of(context).size.width - HomeContentsItem.paddingValue,
                      height: 200.0,
                      fit: BoxFit.fill,
                      fadeInDuration: Duration(milliseconds: 100),
                      fadeOutDuration: Duration(milliseconds: 100)
                    ),
                  ),
                ),
//                      Positioned(
//                        bottom: 0.0,
//                        right: 0.0,
//                        child: Container(
//                          padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
//                          color: const Color.fromRGBO(0xff, 0, 0, 0.9),
//                          child: ,
//                        ),
//                      )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),

            // 좋아요개수
            Opacity(
              opacity: isOrderable && isOpening
                  ? 1
                  : 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            '${widget.summary.cntLike} likes',
                            style: TextStyle()
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: widget.summary.couponType == 0
                        ? Container()
                        : Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1.0)
                      ),
                      child: Text('${widget.summary.couponValue}원 쿠폰', style: TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.w600)),
                    )
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5.0)),

            // 별점, 리뷰개수
            Opacity(
              opacity: isOrderable && isOpening
                  ? 1
                  : 0.5,
              child: Padding(
                padding: const EdgeInsets.only(left: HomeContentsItem.contentsPaddingValue, right: HomeContentsItem.contentsPaddingValue),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.star, color: primaryColor, size: 18),
                    Text(
                        '${widget.summary.avgStar} ・ 리뷰 ${widget.summary.cntComment}',
                        style: TextStyle()
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5.0)),

            // 서브 타이틀
            Opacity(
              opacity: isOrderable && isOpening
                  ? 1
                  : 0.5,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 3.0 + HomeContentsItem.contentsPaddingValue, right: 3.0 + HomeContentsItem.contentsPaddingValue),
                child: Text(
                    '${_removeAllHtmlTags(widget.summary.description)}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    softWrap: true,

                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 26.0)),
          ],
        ),
      ),
    );
  }

  _removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }
}
