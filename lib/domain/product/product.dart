import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';
import 'package:pomangam_client/domain/product/info/product_info.dart';
import 'package:pomangam_client/domain/product/review/product_reply.dart';
import 'package:pomangam_client/domain/product/sub/category/product_sub_category.dart';

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

  // reply
  List<ProductReply> replies;

  // product sub category
  List<ProductSubCategory> productSubCategories = List();

  Product({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.idxStore, this.salePrice, this.productInfo,
    this.productCategoryTitle, this.cntLike, this.cntReply, this.sequence,
    this.productImageMainPath, this.productImageSubPaths, this.isLike, this.replies,
    this.productSubCategories
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}