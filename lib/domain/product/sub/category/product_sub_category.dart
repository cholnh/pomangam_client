import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';
import 'package:pomangam_client/domain/product/sub/product_sub.dart';
import 'package:pomangam_client/domain/product/sub/product_sub_type.dart';

part 'product_sub_category.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductSubCategory extends EntityAuditing {

  String categoryTitle;

  List<ProductSub> productSubs;

  ProductSubType productSubType;

  ProductSub selectedProductSub;

  ProductSubCategory({this.categoryTitle, this.productSubs, this.productSubType});

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) => _$ProductSubCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSubCategoryToJson(this);
  static List<ProductSubCategory> fromJsonList(List<dynamic> jsonList) {
    List<ProductSubCategory> entities = [];
    jsonList.forEach((map) => entities.add(ProductSubCategory.fromJson(map)));
    return entities;
  }

  @override
  String toString() {
    return 'ProductSubCategory{categoryTitle: $categoryTitle, productSubs: $productSubs}';
  }
}