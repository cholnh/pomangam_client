import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/delivery/delivery_site.dart';

part 'delivery_detail_site.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class DeliveryDetailSite {

    int idx;

    DeliverySite deliverySite;

    String title;

    String location;

    int sequence;

    String additionalTime;

    double latitude;

    double longitude;

    String abbreviation;

    DeliveryDetailSite({this.idx, this.deliverySite, this.title, this.location,
        this.sequence, this.additionalTime, this.latitude, this.longitude,
        this.abbreviation});

    factory DeliveryDetailSite.fromJson(Map<String, dynamic> json) => _$DeliveryDetailSiteFromJson(json);
    Map<String, dynamic> toJson() => _$DeliveryDetailSiteToJson(this);
    static List<DeliveryDetailSite> fromJsonList(List<Map<String, dynamic>> jsonList) {
        List<DeliveryDetailSite> entities = [];
        jsonList.forEach((map) => entities.add(DeliveryDetailSite.fromJson(map)));
        return entities;
    }
}