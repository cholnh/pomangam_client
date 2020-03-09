import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/domain/product/product.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_like.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_review.dart';
import 'package:pomangam_client/ui/widget/home/contents/home_contents_item_sub_title.dart';
import 'package:pomangam_client/ui/widget/product/product_app_bar.dart';
import 'package:pomangam_client/ui/widget/product/product_bottom_bar.dart';
import 'package:pomangam_client/ui/widget/product/product_image.dart';
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
      bottomNavigationBar: ProductBottomBar(),
      body: SmartRefresher(
          physics: BouncingScrollPhysics(),
          enablePullDown: true,
          header: WaterDropMaterialHeader(
            color: primaryColor,
            backgroundColor: backgroundColor,
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
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
                    HomeContentsItemReview(
                        cntComment: product?.cntReply ?? 0
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 26.0))
                  ],
                ),
              );
            },
          )
      )
    );
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
}
