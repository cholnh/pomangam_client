import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/provider/store/store_model.dart';

class StoreProductCategory extends StatelessWidget {

  final StoreModel storeModel;

  StoreProductCategory({this.storeModel});

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
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: List.generate(5, (int index) {
            return Container(
              child: Card(
                semanticContainer: true,
                color: index == 0 ? primaryColor : backgroundColor,
                child: Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: Text(
                      '${index==0?'전체':index==1?'메인메뉴':index==2?'서브메뉴':index==3?'토핑':'음료'}',
                      style: TextStyle(color: index==0 ? Colors.white : Colors.black),
                    )
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3,
                margin: EdgeInsets.only(left: 20.0, right: index == 4 ? 20.0 : 0.0, top: 13.0, bottom: 13.0),
              ),
            );
          })
        ),
      ),
    );
  }
}
