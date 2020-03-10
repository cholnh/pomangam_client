import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/product/product.dart';
import 'package:pomangam_client/domain/product/review/product_reply_preview.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_like.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_sub_title.dart';
import 'package:pomangam_client/ui/widget/product/product_app_bar.dart';
import 'package:pomangam_client/ui/widget/product/product_count.dart';
import 'package:pomangam_client/ui/widget/product/product_image.dart';
import 'package:pomangam_client/ui/widget/product/product_price.dart';
import 'package:pomangam_client/ui/widget/product/product_review.dart';
import 'package:pomangam_client/ui/widget/store/store_bottom_bar.dart';
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

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBar(context),
      bottomNavigationBar:  StoreBottomBar(
        centerText: '카트에 추가',
        rightText: '3,500원',
      ),
      body: SmartRefresher(
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
          child: Consumer<ProductModel>(
            builder: (_, model, child) {
              Product product = model.product;

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ProductImage(
                      pIdx: widget.pIdx
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    HomeContentsItemLike(
                      cntLike: product?.cntLike ?? 0,
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 7.0)),
                    HomeContentsItemSubTitle(
                      title: product?.productInfo?.name ?? '',
                      description: product?.productInfo?.description ?? ''
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 7.0)),
                    ProductReview(
                      cntComment: product?.cntReply ?? 0,
                      previews: _dummyData(),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    Divider(height: 0.5),
                    const Padding(padding: EdgeInsets.only(bottom: 15.0)),
                    ProductPrice(),
                    const Padding(padding: EdgeInsets.only(bottom: 7.0)),
                    ProductCount(),
                    const Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  ],
                ),
              );
            },
          )
      )
    );
  }
  
  List<ProductReplyPreview> _dummyData() {
    List<ProductReplyPreview> previews = List();

    previews.add(ProductReplyPreview(isLike: false, idxUser: 1, nickname: 'momstouch', idxProductReply: 1, replyContents: '맛이 좋습니다ㅋㅋ맛이 좋습니다ㅋㅋ맛이 좋습니다ㅋㅋ맛이 좋습니다ㅋㅋ맛이 좋습니다ㅋㅋ맛이 좋습니다ㅋㅋ맛이 좋습니다ㅋㅋ'));
    previews.add(ProductReplyPreview(isLike: true, idxUser: 2, nickname: 'graceful9801', idxProductReply: 1, replyContents: '이딴걸 돈주고 사먹다니 참...'));

    return previews;
  }

  void _init() async {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    StoreModel storeModel = Provider.of<StoreModel>(context, listen: false);
    ProductModel productModel = Provider.of<ProductModel>(context, listen: false);

    // product fetch
    productModel
    ..isProductFetched = false
    ..fetch(
        dIdx: deliverySiteModel.userDeliverySite?.idx,
        sIdx: storeModel.store.idx,
        pIdx: widget.pIdx
    );
  }

  void _onRefresh() async {
    _init();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {

    _refreshController.loadComplete();
  }
}
