import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/key/pmg_key.dart';
import 'package:pomangam_client/_bases/network/constant/endpoint.dart';
import 'package:pomangam_client/_bases/router/app_router.dart';
import 'package:pomangam_client/domains/advertisement/advertisement.dart';
import 'package:pomangam_client/providers/advertisement/advertisement_model.dart';
import 'package:provider/provider.dart';

class HomeAdvertisementWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.deliveryAdvertisement,
      child: Consumer<AdvertisementModel>(
        builder: (_, model, child) {
          if(model.isAdvertisementFetching || model.advertisements.isEmpty) {
            return Container(
              height: 160.0,
              child: Center(child: CupertinoActivityIndicator()),
            );
          }
          return CarouselSlider(
            height: 160.0,
            viewportFraction: 0.9,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: Duration(seconds: 10),
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            items: _advertisementWidgets(model.advertisements)
          );
        },
      )
    );
  }

  List<Widget> _advertisementWidgets(List<Advertisement> advertisements) {
    return advertisements?.map((ad) {
      return Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                    color: Colors.white70
                ),
                child: CachedNetworkImage(
                  imageUrl: '${Endpoint.serverDomain}/${ad.imagePath}',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                )
            ),
            onTap: () => ad.nextLocation == null
              ? {}
              : Navigator.pushNamed(context, ad.nextLocation),
          );
        },
      );
    })?.toList();
  }
}
