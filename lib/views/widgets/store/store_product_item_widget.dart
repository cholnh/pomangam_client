import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/network/constant/endpoint.dart';
import 'package:pomangam_client/domains/product/product_summary.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:provider/provider.dart';

class StoreProductItemWidget extends StatelessWidget {

  final ProductSummary summary;

  StoreProductItemWidget({Key key, this.summary}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductPage(context),
      child: Container(
        key: key,
        decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: backgroundColor)
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.darken,
                child: CachedNetworkImage(
                  imageUrl: '${Endpoint.serverDomain}/${summary.productImageMainPath}',
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                )
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${summary.name}', style: TextStyle(color: Colors.white, fontSize: subTitleFontSize, fontWeight: FontWeight.w500)),
                  Text('${summary.salePrice}', style: TextStyle(color: Colors.white, fontSize: subTitleFontSize, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToProductPage(BuildContext context) {
    Provider.of<ProductModel>(context, listen: false)
    ..product?.productImageSubPaths?.clear()
    ..summary = summary;
    Navigator.pushNamed(context, '/products/${summary.idx}');
  }
}
