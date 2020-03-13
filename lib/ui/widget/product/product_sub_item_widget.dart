import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/domain/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client/domain/product/sub/product_sub.dart';
import 'package:pomangam_client/domain/product/sub/product_sub_type.dart';

class ProductSubItemWidget extends StatelessWidget {

  final ProductSubCategory productSubCategory;

  ProductSubItemWidget({this.productSubCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          color: Color.fromRGBO(0, 0, 0, 0.05),
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
          child: Text('${productSubCategory.categoryTitle}', style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold))
        ),
        _subButtonGroup()
      ],
    );
  }

  Widget _subButtonGroup() {
    List<String> names = productSubCategory.productSubs.map((sub) => sub.productSubInfo.name).toList();
    ProductSubType type = productSubCategory.productSubType;
    String picked = names.first;

    if(type == ProductSubType.CHECKBOX) {
      return CheckboxGroup(
        orientation: GroupedButtonsOrientation.VERTICAL,

        labels: names,
        onSelected: (List selected) => print(selected),
        labelStyle: TextStyle(fontSize: titleFontSize),
        itemBuilder: (Checkbox  rb, Text txt, int i) {
          ProductSub sub = productSubCategory.productSubs[i];
          return ListTile(
            contentPadding: EdgeInsets.only(right: 20.0),
            subtitle: sub?.productSubInfo?.description != null
                ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: subTitleFontSize))
                : null,
            leading: rb,
            title: txt,
            trailing: Text('+ ${sub?.salePrice}원', style: TextStyle(fontSize: titleFontSize)),
          );
        }
      );
    } else if(type == ProductSubType.RADIO) {
      return RadioButtonGroup(
        orientation: GroupedButtonsOrientation.VERTICAL,
        picked: picked,
        labels: names,
        onSelected: (String selected) => print(selected),
        labelStyle: TextStyle(fontSize: titleFontSize),
        itemBuilder: (Radio rb, Text txt, int i) {
          ProductSub sub = productSubCategory.productSubs[i];
          return ListTile(
            contentPadding: EdgeInsets.only(right: 20.0),
            subtitle: sub?.productSubInfo?.description != null
                ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: subTitleFontSize))
                : null,
            leading: rb,
            title: txt,
            trailing: Text('+ ${sub?.salePrice}원', style: TextStyle(fontSize: titleFontSize)),
          );
        }
      );
    } else if(type == ProductSubType.NUMBER) {
      List<Widget> widgets = productSubCategory.productSubs.map((sub) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 20.0, right: 15.0),
          subtitle: sub?.productSubInfo?.description != null
              ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: subTitleFontSize))
              : null,
          title: Text('${sub.productSubInfo.name}', style: TextStyle(fontSize: titleFontSize)),
          trailing: SizedBox(
            height: 40.0,
            width: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('+ ${sub?.salePrice}원', style: TextStyle(fontSize: titleFontSize)),
                Padding(padding: EdgeInsets.only(right: 8.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(3.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(
                            width: 1.5,
                            color: primaryColor
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: backgroundColor, size: 12),
                    ),
                    Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text('1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0))
                    ),
                    Container(
                      margin: EdgeInsets.all(3.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(
                            width: 1.5,
                            color: primaryColor
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.remove, color: backgroundColor, size: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();
      return Column(children: widgets);
    } else if(type == ProductSubType.READONLY) {
      List<Widget> widgets = productSubCategory.productSubs.map((sub) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 20.0, right: 15.0),
          subtitle: sub?.productSubInfo?.description != null
              ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: subTitleFontSize))
              : null,
          title: Text('${sub.productSubInfo.name}', style: TextStyle(fontSize: titleFontSize)),
          trailing: Text('+ ${sub?.salePrice ?? 0}원', style: TextStyle(fontSize: titleFontSize))
        );
      }).toList();
      return Column(children: widgets);
    } else {
      return Container();
    }
  }
}
