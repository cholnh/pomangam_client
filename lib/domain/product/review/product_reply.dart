import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';

part 'product_reply.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductReply extends EntityAuditing {

  /// 리플 작성자 인덱스
  int idxUser;

  /// 제품 인덱스
  int idxProduct;

  /// 익명 유무
  bool isAnonymous;

  /// 리플 내용
  String contents;

  /// 리플 작성자 닉네임
  String nickname;

  /// 자신의 글인지
  bool isOwn;

  /// 좋아요 개수
  int cntLike;

  /// 좋아요 유무
  bool isLike;


  ProductReply({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.idxUser, this.idxProduct, this.isAnonymous, this.contents,
    this.nickname, this.isOwn, this.cntLike, this.isLike
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory ProductReply.fromJson(Map<String, dynamic> json) => _$ProductReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ProductReplyToJson(this);
  static List<ProductReply> fromJsonList(List<dynamic> jsonList) {
    List<ProductReply> entities = [];
    jsonList.forEach((map) => entities.add(ProductReply.fromJson(map)));
    return entities;
  }
}