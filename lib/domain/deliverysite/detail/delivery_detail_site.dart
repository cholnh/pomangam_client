import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/common/entity_auditing.dart';

part 'delivery_detail_site.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class DeliveryDetailSite extends EntityAuditing {

    int idxDeliverySite;

    String name;

    String location;

    int sequence;

    String additionalTime;

    double latitude;

    double longitude;

    String abbreviation;

    DeliveryDetailSite({
        int idx, DateTime registerDate, DateTime modifyDate,
        this.idxDeliverySite, this.name, this.location,
        this.sequence, this.additionalTime, this.latitude, this.longitude,
        this.abbreviation
    }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

    factory DeliveryDetailSite.fromJson(Map<String, dynamic> json) => _$DeliveryDetailSiteFromJson(json);
    Map<String, dynamic> toJson() => _$DeliveryDetailSiteToJson(this);
    static List<DeliveryDetailSite> fromJsonList(List<Map<String, dynamic>> jsonList) {
      List<DeliveryDetailSite> entities = [];
      jsonList.forEach((map) => entities.add(DeliveryDetailSite.fromJson(map)));
      return entities;
    }

    TimeOfDay getAdditionalTime()
      => TimeOfDay.fromDateTime(DateFormat('hh:mm:ss').parse(this.additionalTime).toUtc());
}