import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';
import 'package:pomangam_client/domains/product/category/product_category.dart';
import 'package:pomangam_client/domains/store/info/production_info.dart';
import 'package:pomangam_client/domains/store/info/store_info.dart';
import 'package:pomangam_client/domains/store/schedule/store_schedule.dart';
import 'package:pomangam_client/domains/store/story/store_story.dart';

part 'store.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Store extends EntityAuditing {

  /// 배달지 인덱스
  int idxDeliverySite;

  /// 업체 분류
  String storeCategory;

  /// 업체 정보
  StoreInfo storeInfo;

  /// 업체 생산량
  ProductionInfo productionInfo;

  /// 업체 영업 시간
  StoreSchedule storeSchedule;

  /// 평균 리뷰 평점
  double avgStar;

  /// 총 좋아요 개수
  int cntLike;

  /// 총 리뷰 개수
  int cntComment;

  /// 총 주문 개수
  int cntOrder;

  /// 순서
  int sequence;

  /// 브랜드(로고) 이미지 경로
  String brandImagePath;

  /// 업체 대표 이미지 경로
  String storeImageMainPath;

  /// 업체 서브 이미지 경로 리스트
  List<String> storeImageSubPaths;

  /// 업체 제품 카테고리 리스트
  List<ProductCategory> productCategories;

  /// 스토리 리스트
  List<StoreStory> stories;

  /// 좋아요 유무
  bool isLike;

  Store({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.storeInfo, this.productionInfo, this.storeSchedule,
    this.avgStar, this.cntLike, this.cntComment, this.cntOrder, this.sequence,
    this.brandImagePath, this.storeImageMainPath, this.storeImageSubPaths,
    this.productCategories, this.stories, this.isLike
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}