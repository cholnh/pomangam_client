import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';

part 'store_story.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class StoreStory extends EntityAuditing {

  String title;

  List<String> images;

  int sequence;

  StoreStory({this.title, this.images, this.sequence});

  factory StoreStory.fromJson(Map<String, dynamic> json) => _$StoreStoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoreStoryToJson(this);
}