import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class HomeContentsItemImageWidget extends StatelessWidget {

  final PageController _controller = PageController();

  final double opacity;
  final double height;
  final List<String> imagePaths;

  HomeContentsItemImageWidget({this.opacity, this.height, this.imagePaths});

  @override
  Widget build(BuildContext context) {

    List<Widget> items = imagePaths.map((imagePath)
      => _buildPage(context, imagePath)).toList();

    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                children: items,
                controller: _controller,
              ),
            ),
            imagePaths.length > 1
              ? Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ScrollingPageIndicator(
                    dotColor: Colors.black12,
                    dotSelectedColor: primaryColor,
                    dotSize: 5,
                    dotSelectedSize: 6,
                    dotSpacing: 9,
                    controller: _controller,
                    itemCount: imagePaths.length,
                    orientation: Axis.horizontal
                  ),
                )
              : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, String imagePath) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
          width: width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.3)
          ),
          child: CachedNetworkImage(
            key: PmgKeys.homeContentsItemImage,
            imageUrl: '${Endpoint.serverDomain}/$imagePath',
            fit: BoxFit.fill,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error_outline),
          )
      ),
    );
  }
}
