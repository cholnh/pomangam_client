import 'package:pomangam_client/domain/store/store_entity.dart';

storeEntityFromJson(StoreEntity data, Map<String, dynamic> json) {
	if (json['idx'] != null) {
		data.idx = json['idx']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['location'] != null) {
		data.location = json['location']?.toString();
	}
	if (json['main_phone_number'] != null) {
		data.mainPhoneNumber = json['main_phone_number']?.toString();
	}
	if (json['description'] != null) {
		data.description = json['description']?.toString();
	}
	if (json['cnt_like'] != null) {
		data.cntLike = json['cnt_like']?.toInt();
	}
	if (json['cnt_comment'] != null) {
		data.cntComment = json['cnt_comment']?.toInt();
	}
	if (json['minimum_time'] != null) {
		data.minimumTime = json['minimum_time']?.toString();
	}
	if (json['parallel_production'] != null) {
		data.parallelProduction = json['parallel_production']?.toInt();
	}
	if (json['maximum_production'] != null) {
		data.maximumProduction = json['maximum_production']?.toInt();
	}
	if (json['register_date'] != null) {
		data.registerDate = json['register_date']?.toString();
	}
	if (json['modify_date'] != null) {
		data.modifyDate = json['modify_date']?.toString();
	}
	if (json['sequence'] != null) {
		data.sequence = json['sequence']?.toInt();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	return data;
}

Map<String, dynamic> storeEntityToJson(StoreEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['idx'] = entity.idx;
	data['name'] = entity.name;
	data['location'] = entity.location;
	data['main_phone_number'] = entity.mainPhoneNumber;
	data['description'] = entity.description;
	data['cnt_like'] = entity.cntLike;
	data['cnt_comment'] = entity.cntComment;
	data['minimum_time'] = entity.minimumTime;
	data['parallel_production'] = entity.parallelProduction;
	data['maximum_production'] = entity.maximumProduction;
	data['register_date'] = entity.registerDate;
	data['modify_date'] = entity.modifyDate;
	data['sequence'] = entity.sequence;
	data['type'] = entity.type;
	return data;
}