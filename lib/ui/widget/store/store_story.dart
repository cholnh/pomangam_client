import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';

class StoreStory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeStory,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            height: 140,
            child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: List.generate(10, (int index) {
                  return Container(
                    margin: EdgeInsets.only(left: 20.0, right: index == 9 ? 20.0 : 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 8.0),
                          width: 70.0,
                          height: 70.0,
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black26,
                              width: 1.0,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${Endpoint.serverDomain}/assets/images/dsites/1/stores/1/reviews/1/${Random().nextInt(9)+1}.jpg'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(
                          '리뷰입니다...',
                          maxLines: 1,
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                  );
                })
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 0.0), child: Divider(height: 0.5))
        ],
      ),
    );
  }
}
