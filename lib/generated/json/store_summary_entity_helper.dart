import 'package:pomangam_client/domain/store/store_summary_entity.dart';

storeSummaryEntityFromJson(StoreSummaryEntity data, Map<String, dynamic> json) {
	if (json['idx'] != null) {
		data.idx = json['idx']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
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
	if (json['sequence'] != null) {
		data.sequence = json['sequence']?.toInt();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['imgpath'] != null) {
		data.imgpath = json['imgpath']?.toString();
	}
	return data;
}

Map<String, dynamic> storeSummaryEntityToJson(StoreSummaryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['idx'] = entity.idx;
	data['name'] = entity.name;
	data['description'] = entity.description;
	data['cnt_like'] = entity.cntLike;
	data['cnt_comment'] = entity.cntComment;
	data['sequence'] = entity.sequence;
	data['type'] = entity.type;
	data['imgpath'] = entity.imgpath;
	return data;
}