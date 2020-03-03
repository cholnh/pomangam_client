import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/domain/store/store_summary.dart';
import 'package:transparent_image/transparent_image.dart';
class HomeContentsItemImage extends StatefulWidget {

  final bool isOpening;
  final bool isOrderable;
  final StoreSummary summary;

  HomeContentsItemImage({this.isOpening, this.isOrderable, this.summary});

  @override
  _HomeContentsItemImageState createState() => _HomeContentsItemImageState();
}

class _HomeContentsItemImageState extends State<HomeContentsItemImage> {

  int _current = 0;
  List<String> _imagePaths;

  @override
  void initState() {
    super.initState();
    _imagePaths = List()
      ..add(widget.summary.storeImageMainPath)
      ..addAll(widget.summary.storeImageSubPaths);
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isOrderable && widget.isOpening
          ? 1
          : 0.5,
      child: Column(
        children: <Widget>[
          CarouselSlider(
            height: 200.0,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            autoPlay: false,
            scrollDirection: Axis.horizontal,
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            items: _imagePaths.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.3)
                        ),
                        child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: '${Endpoint.serverDomain}$imagePath',
                            fit: BoxFit.fill,
                            fadeInDuration: Duration(milliseconds: 100),
                            fadeOutDuration: Duration(milliseconds: 100)
                        )
                    ),
                  );
                },
              );
            }).toList(),
          ),
          _imagePaths.length > 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                  _imagePaths,
                      (index, url) {
                    return Container(
                      width: 6.0,
                      height: 6.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? primaryColor
                              : Color.fromRGBO(0, 0, 0, 0.4)),
                    );
                  },
                )
              )
            : Container()
        ],
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}