import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';

class DeliveryAdvertisement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      key: PmgKeys.deliveryAdvertisement,
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return CarouselSlider(
            height: 160.0,
            viewportFraction: 0.9,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: Duration(seconds: 10),
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,

            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                            color: Colors.amber
                        ),
                        child: Center(
                            child: Text('AD$i', style: TextStyle(fontSize: 16.0))
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
