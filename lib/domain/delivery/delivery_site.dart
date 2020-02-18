import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/delivery/region/region.dart';

part 'delivery_site.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class DeliverySite {
    int idx;

    String title;

    String location;

    String campus;

    Region region;

    DeliverySite({this.idx, this.title, this.location, this.campus, this.region});

    factory DeliverySite.fromJson(Map<String, dynamic> json) => _$DeliverySiteFromJson(json);
    Map<String, dynamic> toJson() => _$DeliverySiteToJson(this);
    static List<DeliverySite> fromJsonList(List<Map<String, dynamic>> jsonList) {
        List<DeliverySite> entities = [];
        jsonList.forEach((map) => entities.add(DeliverySite.fromJson(map)));
        return entities;
    }
}