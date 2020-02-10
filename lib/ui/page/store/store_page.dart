import 'package:flutter/material.dart';
import 'package:pomangam_client/common/network/constant/endpoint.dart';
import 'package:pomangam_client/domain/store/store.dart';
import 'package:pomangam_client/provider/store/store_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<StoreModel>(
          builder: (_, model, child) {
            Store store = model.store;
            return Hero(
              tag: 'storeImageHero',
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: '${Endpoint.serverDomain}${store.brandImagePath}',
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                fit: BoxFit.fill,
              ),
            );
          },
        ),
      ),
    );
  }
}
