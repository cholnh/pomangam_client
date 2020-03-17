import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/providers/product/sub/product_sub_category_model.dart';
import 'package:provider/provider.dart';

class ProductCustomImage2Widget extends StatelessWidget {

  final Color borderColor = Color.fromRGBO(0, 0, 0, 0.8); // primaryColor
  final double borderWidth = 2.5;
  final Color innerShadowColor = Colors.black26;
  final Color bottomColor = Colors.white; // Color.fromRGBO(0, 0, 0, 0.1)

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSubCategoryModel>(
      builder: (_, categoryModel, child) {
        int selected = categoryModel.idxSelectedCategory;
        return Container(
          height: 180,
          margin: EdgeInsets.only(bottom: 0.0),
          padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 20.0, top: 20.0),
          color: Color.fromRGBO(0, 0, 0, 0.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 10),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: bottomColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0)
                              ),
                              border: Border.all(
                                  color: borderColor,
                                  width: borderWidth
                              )
                          ),
                          child: Center(
                            child: Text(
                              '선택2',
                              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: bottomColor,
                              borderRadius: BorderRadius.only(
                                  topRight: const Radius.circular(10.0)
                              ),
                              border: Border.all(
                                  color: borderColor,
                                  width: borderWidth
                              )
                          ),
                          child: Center(
                            child: Text(
                              '선택3',
                              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                    )
                  ],
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: bottomColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(10.0),
                          bottomRight: const Radius.circular(10.0)
                      ),
                      border: Border.all(
                          color: borderColor,
                          width: borderWidth
                      )
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '서리태밥',
                          style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '+300원',
                          style: TextStyle(fontSize: subTitleFontSize),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
