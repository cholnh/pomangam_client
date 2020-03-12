import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreBrandImageWidget extends StatelessWidget {

  final int sIdx;
  final String brandImagePath;

  StoreBrandImageWidget({this.sIdx, this.brandImagePath});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'storeImageHero$sIdx',
        child: Container(
            child: CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: '$brandImagePath',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.white
            ),
            width: 75.0,
            height: 75.0,
            padding: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            )
        )
    );
  }
}
