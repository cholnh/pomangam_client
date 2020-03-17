import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domains/_bases/entity_auditing.dart';

part 'region.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Region extends EntityAuditing {

  String name;

  Region({
    int idx, DateTime registerDate, DateTime modifyDate, this.name
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
  static List<Region> fromJsonList(List<Map<String, dynamic>> jsonList) {
      List<Region> entities = [];
      jsonList.forEach((map) => entities.add(Region.fromJson(map)));
      return entities;
  }
}