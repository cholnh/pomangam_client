import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class ProductImage extends StatelessWidget {

  final int pIdx;
  final PageController _controller = PageController();

  ProductImage({this.pIdx});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (_, model, child) {

        List<String> imagePaths = List();
        imagePaths.clear();
        List<Widget> items = List();
        items.add(_buildPage(context, model.summary?.productImageMainPath, true));
        if(model.product != null) {
          imagePaths.addAll(model.product.productImageSubPaths);
        }
        items.addAll(imagePaths?.map((imagePath)
          => _buildPage(context, imagePath, false))?.toList());

        return SizedBox(
          key: PmgKeys.productImage,
          height: MediaQuery.of(context).size.width - 70,
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: items,
                  controller: _controller,
                ),
              ),
              Opacity(
                opacity: (imagePaths.length + 1) > 1 ? 1 : 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: ScrollingPageIndicator(
                        dotColor: Colors.black12,
                        dotSelectedColor: primaryColor,
                        dotSize: 5,
                        dotSelectedSize: 6,
                        dotSpacing: 9,
                        controller: _controller,
                        itemCount: (imagePaths.length + 1),
                        orientation: Axis.horizontal
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context, String imagePath, bool isHero) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
          width: width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.3)
          ),
          child: isHero
            ? Hero(
                tag: 'productImageHero$pIdx',
                child: CachedNetworkImage(
                  imageUrl: '${Endpoint.serverDomain}/$imagePath',
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                ),
              )
            : CachedNetworkImage(
                imageUrl: '${Endpoint.serverDomain}/$imagePath',
                fit: BoxFit.fill,
                placeholder: (context, url) => CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              )
      ),
    );
  }
}
