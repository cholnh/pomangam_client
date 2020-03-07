import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class HomeContentsItemImage extends StatefulWidget {

  final bool isOpening;
  final bool isOrderable;
  final StoreSummary summary;

  HomeContentsItemImage({this.isOpening, this.isOrderable, this.summary});

  @override
  _HomeContentsItemImageState createState() => _HomeContentsItemImageState();
}

class _HomeContentsItemImageState extends State<HomeContentsItemImage> {

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();

    List<String> imagePaths = List()
      ..add(widget.summary.storeImageMainPath)
      ..addAll(widget.summary.storeImageSubPaths);

    List<Widget> items = imagePaths.map((imagePath)
      => _buildPage(imagePath)).toList();

    return Opacity(
      opacity: widget.isOrderable && widget.isOpening
          ? 1
          : 0.5,
      child: SizedBox(
        height: 250.0,
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

  Widget _buildPage(String imagePath) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
          width: width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.3)
          ),
          child: FadeInImage.memoryNetwork(
            key: PmgKeys.homeContentsItemImage,
            placeholder: kTransparentImage,
            image: '${Endpoint.serverDomain}$imagePath',
            fit: BoxFit.fill,
            fadeInDuration: Duration(milliseconds: 100),
            fadeOutDuration: Duration(milliseconds: 100),
          )
      ),
    );
  }
}
