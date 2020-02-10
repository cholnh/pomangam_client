import 'package:json_annotation/json_annotation.dart';

part 'region.g.dart';

@JsonSerializable(nullable: true)
class Region {
  int idx;

  String title;

  Region(this.idx, this.title);

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
  static List<Region> fromJsonList(List<Map<String, dynamic>> jsonList) {
      List<Region> entities = [];
      jsonList.forEach((map) => entities.add(Region.fromJson(map)));
      return entities;
  }
}