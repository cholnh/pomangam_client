import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';
import 'package:pomangam_client/domain/product/sub/info/product_sub_info.dart';

part 'product_sub.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductSub extends EntityAuditing {

  int idxStore;

  int salePrice;

  ProductSubInfo productSubInfo;

  int sequence;

  String productSubCategory;

  int numberMinimum;

  int numberMaximum;

  ProductSub({
    this.idxStore, this.salePrice, this.productSubInfo, this.sequence,
    this.productSubCategory, this.numberMinimum, this.numberMaximum
  });

  factory ProductSub.fromJson(Map<String, dynamic> json) => _$ProductSubFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSubToJson(this);
  static List<ProductSub> fromJsonList(List<dynamic> jsonList) {
    List<ProductSub> entities = [];
    jsonList.forEach((map) => entities.add(ProductSub.fromJson(map)));
    return entities;
  }

  @override
  String toString() {
    return 'ProductSub{idxStore: $idxStore, salePrice: $salePrice, productSubInfo: $productSubInfo, sequence: $sequence, productSubCategory: $productSubCategory, numberMinimum: $numberMinimum, numberMaximum: $numberMaximum}';
  }
}
