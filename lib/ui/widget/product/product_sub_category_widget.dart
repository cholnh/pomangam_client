import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/domain/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client/provider/product/product_model.dart';
import 'package:pomangam_client/provider/product/sub/product_sub_category_model.dart';
import 'package:provider/provider.dart';

class ProductSubCategoryWidget extends StatelessWidget {

  final int pIdx;
  final Function(int, int) onSelected;
  final GlobalKey keyProductSubCategory;

  ProductSubCategoryWidget({this.keyProductSubCategory, this.pIdx, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: PmgKeys.productSubCategory,
      backgroundColor: backgroundColor,
      floating: true,
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.8,
      title: Container(
        height: 60,
        child: Consumer<ProductSubCategoryModel>(
          builder: (_, categoryModel, child) {
            int selected = categoryModel.idxSelectedCategory;
            return Consumer<ProductModel>(
              builder: (_, productModel, child) {
                List<ProductSubCategory> subCategories = productModel?.product?.productSubCategories;
                return ListView.builder(
                  key: keyProductSubCategory,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: subCategories == null ? 0 : subCategories.length+1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () => _onSelected(index, null),
                        child: Card(
                          semanticContainer: true,
                          color: index == selected ? primaryColor : backgroundColor,
                          child: Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text(
                              '전체',
                              style: TextStyle(color: index == selected ? Colors.white : Colors.black, fontSize: titleFontSize),
                             )
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.only(left: 15.0, top: 13.0, bottom: 13.0),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () => _onSelected(index, subCategories[index-1].idx),
                        child: Card(
                          semanticContainer: true,
                          color: index == selected ? primaryColor : backgroundColor,
                          child: Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text(
                              '${subCategories[index-1].categoryTitle}',
                              style: TextStyle(color: index == selected ? Colors.white : Colors.black, fontSize: titleFontSize),
                            )
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.only(left: 15.0, right: index == subCategories.length ? 15.0 : 0.0, top: 13.0, bottom: 13.0),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        ),
      ),
    );
  }

  void _onSelected(int idxSelected, int idxProductSubCategory) {
    this.onSelected(idxSelected, idxProductSubCategory);
  }
}
