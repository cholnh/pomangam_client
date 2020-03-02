import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeAdvertisement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      key: PmgKeys.deliveryAdvertisement,
      delegate: SliverChildBuilderDelegate((context, index) {
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

            items: [3,2,1,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                            color: Colors.white70
                        ),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: '${Endpoint.serverDomain}/assets/images/dsites/1/advertisements/$i.png',
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                          fit: BoxFit.fill,
                          fadeInDuration: Duration(milliseconds: 100),
                          fadeOutDuration: Duration(milliseconds: 100)
                        )
                    ),
                    onTap: () => print('AD$i clicked!'),
                  );
                },
              );
            }).toList(),
          );
        },
        childCount: 1,
      ),
    );
  }
}
