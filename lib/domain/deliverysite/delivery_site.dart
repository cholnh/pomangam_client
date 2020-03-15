import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';

part 'delivery_site.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class DeliverySite extends EntityAuditing {

    String name;

    String location;

    String campus;

    int idxRegion;

    DeliverySite({int idx, DateTime registerDate, DateTime modifyDate,
        this.name, this.location, this.campus, this.idxRegion
    }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

    factory DeliverySite.fromJson(Map<String, dynamic> json) => _$DeliverySiteFromJson(json);
    Map<String, dynamic> toJson() => _$DeliverySiteToJson(this);
    static List<DeliverySite> fromJsonList(List<dynamic> jsonList) {
        List<DeliverySite> entities = [];
        jsonList.forEach((map) => entities.add(DeliverySite.fromJson(map)));
        return entities;
    }
}