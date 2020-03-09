import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';
import 'package:pomangam_client/domain/product/info/product_info.dart';

part 'product.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Product extends EntityAuditing {

  int idxStore;
  int salePrice;
  ProductInfo productInfo;
  String productCategoryTitle;
  int cntLike;
  int cntReply;
  int sequence;

  // images
  String productImageMainPath;
  List<String> productImageSubPaths;

  // like
  bool isLike;

  Product({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.idxStore, this.salePrice, this.productInfo,
    this.productCategoryTitle, this.cntLike, this.cntReply, this.sequence,
    this.productImageMainPath, this.productImageSubPaths, this.isLike
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}