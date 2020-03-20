import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/key/pmg_key.dart';
import 'package:pomangam_client/_bases/network/constant/endpoint.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class ProductImageWidget extends StatelessWidget {

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (_, model, child) {
        List<String> imagePaths = List();
        if(model.product != null) {
          imagePaths.add(model.product.productImageMainPath);
          imagePaths.addAll(model.product.productImageSubPaths);
        }

        return SizedBox(
          key: PmgKeys.productImage,
          height: MediaQuery.of(context).size.width - 70,
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: _buildPage(context, imagePaths),
                  controller: _controller,
                ),
              ),
              Opacity(
                opacity: (imagePaths.length) > 1 ? 1 : 0,
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
                      itemCount: (imagePaths.length),
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

  List<Widget> _buildPage(BuildContext context, List<String> imagePaths) {
    return imagePaths.map((imagePath) {
      return GestureDetector(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: '${Endpoint.serverDomain}/$imagePath',
              fit: BoxFit.fill,
              placeholder: (context, url) => CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error_outline),
            )
        ),
      );
    }).toList();
  }
}
