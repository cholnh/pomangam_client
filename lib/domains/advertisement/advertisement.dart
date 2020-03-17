import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/advertisement/advertisement_type.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

part 'advertisement.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Advertisement extends EntityAuditing {
  AdvertisementType advertisementType;
  String imagePath;
  String nextLocation;
  int sequence;

  Advertisement({
    this.advertisementType, this.imagePath, this.nextLocation,
    this.sequence
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) => _$AdvertisementFromJson(json);
  Map<String, dynamic> toJson() => _$AdvertisementToJson(this);
  static List<Advertisement> fromJsonList(List<dynamic> jsonList) {
    List<Advertisement> entities = [];
    jsonList.forEach((map) => entities.add(Advertisement.fromJson(map)));
    return entities;
  }
}