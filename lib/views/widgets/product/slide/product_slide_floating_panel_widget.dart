import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/router/app_router.dart';
import 'package:pomangam_client/domains/product/product.dart';
import 'package:pomangam_client/domains/product/sub/product_sub.dart';
import 'package:pomangam_client/providers/cart/cart_model.dart';
import 'package:pomangam_client/providers/product/product_model.dart';
import 'package:pomangam_client/providers/store/store_model.dart';
import 'package:provider/provider.dart';

class ProductSlideFloatingPanelWidget extends StatefulWidget {

  @override
  _ProductSlideFloatingPanelWidgetState createState() => _ProductSlideFloatingPanelWidgetState();
}

class _ProductSlideFloatingPanelWidgetState extends State<ProductSlideFloatingPanelWidget> {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]
      ),
      margin: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('가게 사장님에게', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.only(bottom: 8.0)),
                TextField(
                  controller: _textEditingController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: '예) 피클 빼주세요.',
                    hintStyle: TextStyle(fontSize: titleFontSize, color: Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel, size: 18.0),
                      onPressed: () => WidgetsBinding.instance.addPostFrameCallback((_) => _textEditingController.clear()),
                    )
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                  keyboardType: TextInputType.text,
                ),
                Consumer<ProductModel>(
                  builder: (_, model, child) {
                    return model.userRecentRequirement != null
                    ? GestureDetector(
                      onTap: () => model.toggleIsUserRecentRequirement(),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: model.isUserRecentRequirement,
                          ),
                          Text('${model.userRecentRequirement}', style: TextStyle(fontSize: titleFontSize, color: Colors.black.withOpacity(0.5)))
                        ],
                      ),
                    )
                    : Container();
                  },
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Container(
                color: primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 53.0,
                child: Center(
                  child: Text('확인', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)),
                ),
              ),
              onTap: _onDialogSelected,
            ),
          )
        ],
      ),
    );
  }

  void _onDialogSelected() {
    StoreModel storeModel = Provider.of<StoreModel>(context, listen: false);
    ProductModel productModel = Provider.of<ProductModel>(context, listen: false);
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);

    Product product = productModel.product;
    List<ProductSub> selectedSubs = List();
    product?.productSubCategories?.forEach((subCategory) => selectedSubs.addAll(subCategory.selectedProductSub));

    String requirement = _textEditingController.text;
    requirement += (productModel.isUserRecentRequirement
      ? (requirement.isEmpty ? '' : ', ') + '${productModel.userRecentRequirement}'
      : '');

    // add
    cartModel.addItem(
      store: storeModel.store,
      product: product,
      quantity: productModel.quantity,
      subs: selectedSubs,
      requirement: requirement
    );

    Injector.appInstance.getDependency<AppRouter>()
      .pop(context);
    Fluttertoast.showToast(
      msg: "카트에 추가되었습니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      fontSize: titleFontSize
    );
  }
}
