import 'package:flutter/material.dart';

class StoreBrandImage extends StatelessWidget {

  final int sIdx;
  final String brandImagePath;

  StoreBrandImage({this.sIdx, this.brandImagePath});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'storeImageHero$sIdx',
        child: Container(
            child: CircleAvatar(
                child: Image.network(
                  '$brandImagePath',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
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
