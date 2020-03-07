// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliverySite _$DeliverySiteFromJson(Map<String, dynamic> json) {
  return DeliverySite(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    name: json['name'] as String,
    location: json['location'] as String,
    campus: json['campus'] as String,
    idxRegion: json['idxRegion'] as int,
  );
}

Map<String, dynamic> _$DeliverySiteToJson(DeliverySite instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'name': instance.name,
      'location': instance.location,
      'campus': instance.campus,
      'idxRegion': instance.idxRegion,
    };
