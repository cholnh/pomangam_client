import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:pomangam_client/providers/sign/sign_in_model.dart';
import 'package:pomangam_client/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class ProductAppBar extends AppBar {
  ProductAppBar(context) : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, color: Colors.black),
      onPressed:() => Navigator.pop(context, false),
    ),
    centerTitle: true,
    title: Consumer<ProductModel>(
      builder: (_, model, child) {
        return Column(
          children: <Widget>[
            Text(
              '${model?.summary?.name ?? ''}',
              style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600)
            ),
            Text(
                '${model?.product?.productCategoryTitle ?? ''}',
                style: TextStyle(color: Colors.black45, fontSize: subTitleFontSize)
            ),
          ],
        );
      },
    ),
    actions: <Widget>[
      Consumer<ProductModel>(
        builder: (_, model, child) {
          return IconButton(
            icon: model?.product?.isLike != null &&  model.product.isLike
                ? const Icon(Icons.favorite, color: primaryColor)
                : const Icon(Icons.favorite_border, color: primaryColor),
            onPressed: () => _onPressed(context: context, model: model),
          );
        },
      )
    ],
    elevation: 0.0,
  );
}

void _onPressed({BuildContext context, ProductModel model}) {
  if(model.product == null) return;

  bool isSignIn = Provider.of<SignInModel>(context, listen: false).isSignIn();
  if(isSignIn) {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    model.likeToggle(
        dIdx: deliverySiteModel.userDeliverySite?.idx,
        sIdx: model.product.idxStore,
        pIdx: model.product?.idx
    );
  } else {
    showSignModal(context: context, returnUrl: '/products/${model.product?.idx}');
  }
}