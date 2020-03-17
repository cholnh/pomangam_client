import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class StoreReviewPreview extends EntityAuditing {

  /// 리뷰 작성자 인덱스
  int idxUser;

  /// 리뷰 작성자 닉네임
  String nickname;

  /// 리뷰 인덱스
  int idxStoreReview;

  /// 리뷰 제목
  String reviewTitle;

  StoreReviewPreview({this.idxUser, this.nickname, this.idxStoreReview, this.reviewTitle});

}