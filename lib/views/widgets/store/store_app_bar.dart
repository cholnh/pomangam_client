import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/initalizer/initializer.dart';
import 'package:pomangam_client/providers/store/store_model.dart';
import 'package:pomangam_client/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class StoreAppBar extends AppBar {
  StoreAppBar(context) : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, color: Colors.black),
      onPressed:() => Navigator.pop(context, false),
    ),
    centerTitle: true,
    title: Consumer<StoreModel>(
      builder: (_, model, child) {
        return Text(
            '${model?.store?.storeInfo?.name ?? ''}',
            style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
        );
      },
    ),
    actions: <Widget>[
      Consumer<StoreModel>(
        builder: (_, model, child) {
          return IconButton(
            icon: model?.store?.isLike != null &&  model.store.isLike
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

void _onPressed({BuildContext context, StoreModel model}) async {
  bool isSignIn = await Initializer.isSignIn();
  if(isSignIn) {
    model.likeToggle(
        dIdx: model.store?.idxDeliverySite,
        sIdx: model.store?.idx
    );
  } else {
    showModal(context: context);
  }
}