import 'package:pomangam_client/generated/json/base/json_convert_content.dart';
import 'package:pomangam_client/generated/json/base/json_filed.dart';

class StoreEntity with JsonConvert<StoreEntity> {
	int idx;
	String name;
	String location;
	@JSONField(name: "main_phone_number")
	String mainPhoneNumber;
	String description;
	@JSONField(name: "cnt_like")
	int cntLike;
	@JSONField(name: "cnt_comment")
	int cntComment;
	@JSONField(name: "minimum_time")
	String minimumTime;
	@JSONField(name: "parallel_production")
	int parallelProduction;
	@JSONField(name: "maximum_production")
	int maximumProduction;
	@JSONField(name: "register_date")
	String registerDate;
	@JSONField(name: "modify_date")
	String modifyDate;
	int sequence;
	int type;
}
