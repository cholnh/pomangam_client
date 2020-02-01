import 'package:pomangam_client/generated/json/base/json_convert_content.dart';
import 'package:pomangam_client/generated/json/base/json_filed.dart';

class StoreSummaryEntity with JsonConvert<StoreSummaryEntity> {
	int idx;
	String name;
	String description;
	@JSONField(name: "cnt_like")
	int cntLike;
	@JSONField(name: "cnt_comment")
	int cntComment;
	int sequence;
	int type;
	String imgpath;

	@override
	String toString() {
		return 'StoreSummaryEntity{idx: $idx, name: $name, description: $description, cntLike: $cntLike, cntComment: $cntComment, sequence: $sequence, type: $type, imgpath: $imgpath}';
	}
}
