import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/domain/product/category/product_category.dart';
import 'package:pomangam_client/provider/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client/provider/product/product_summary_model.dart';
import 'package:pomangam_client/provider/store/store_product_category_model.dart';
import 'package:provider/provider.dart';

class StoreProductCategory extends StatelessWidget {

  final int dIdx;
  final int sIdx;
  final List<ProductCategory> productCategories;

  StoreProductCategory({this.dIdx, this.sIdx, this.productCategories});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: PmgKeys.storeProductCategory,
      backgroundColor: backgroundColor,
      floating: true,
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.8,
      title: Container(
        height: 60,
        child: Consumer<StoreProductCategoryModel>(
          builder: (_, model, child) {
            int selected = model.idxSelectedCategory;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: productCategories == null ? 0 : productCategories.length+1,
              itemBuilder: (context, index) {
                return index == 0
                  ? GestureDetector(
                      onTap: () => _onSelected(context, index, null),
                      child: Card(
                        semanticContainer: true,
                        color: index == selected ? primaryColor : backgroundColor,
                        child: Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text(
                              '전체',
                              style: TextStyle(color: index == selected ? Colors.white : Colors.black),
                            )
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 3,
                        margin: EdgeInsets.only(left: 20.0, top: 13.0, bottom: 13.0),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => _onSelected(context, index, productCategories[index-1].idx),
                      child: Card(
                        semanticContainer: true,
                        color: index == selected ? primaryColor : backgroundColor,
                        child: Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text(
                              '${productCategories[index-1].categoryTitle}',
                              style: TextStyle(color: index == selected ? Colors.white : Colors.black),
                            )
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 3,
                        margin: EdgeInsets.only(left: 20.0, right: index == productCategories.length ? 20.0 : 0.0, top: 13.0, bottom: 13.0),
                      ),
                    );
              },
            );
          }
        ),
      ),
    );
  }

  void _onSelected(BuildContext context, int idxSelected, int idxProductCategory) {
    Provider.of<StoreProductCategoryModel>(context, listen: false)
        .changeIdxSelectedCategory(idxSelected);
    StoreProductCategoryModel storeProductCategoryModel = Provider.of<StoreProductCategoryModel>(context, listen: false);
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false)
      ..clear();
    if(idxProductCategory == null) {
      storeProductCategoryModel.idxProductCategory = 0;
      productSummaryModel.fetch(
        isForceUpdate: true,
        dIdx: dIdx,
        sIdx: sIdx,
      );
    } else {
      storeProductCategoryModel.idxProductCategory = idxProductCategory;
      productSummaryModel.fetch(
        isForceUpdate: true,
        dIdx: dIdx,
        sIdx: sIdx,
        cIdx: idxProductCategory
      );
    }
  }
}
