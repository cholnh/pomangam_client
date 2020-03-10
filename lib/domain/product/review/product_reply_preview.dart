import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';

part 'product_reply_preview.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductReplyPreview extends EntityAuditing {

  /// 리플 작성자 인덱스
  int idxUser;

  /// 리플 작성자 닉네임
  String nickname;

  /// 리플 인덱스
  int idxProductReply;

  /// 리플 내용
  String replyContents;

  /// 좋아요 유무
  bool isLike;

  ProductReplyPreview({this.idxUser, this.nickname, this.idxProductReply, this.replyContents, this.isLike});

  factory ProductReplyPreview.fromJson(Map<String, dynamic> json) => _$ProductReplyPreviewFromJson(json);
  Map<String, dynamic> toJson() => _$ProductReplyPreviewToJson(this);
  static List<ProductReplyPreview> fromJsonList(List<dynamic> jsonList) {
    List<ProductReplyPreview> entities = [];
    jsonList.forEach((map) => entities.add(ProductReplyPreview.fromJson(map)));
    return entities;
  }
}