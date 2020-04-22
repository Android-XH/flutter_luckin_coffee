import 'package:flutter_luckin_coffee/jsonserialize/user/base_date_entity.dart';

baseDateEntityFromJson(BaseDateEntity data, Map<String, dynamic> json) {
	if (json['errno'] != null) {
		data.errno = json['errno']?.toInt();
	}
	if (json['errmsg'] != null) {
		data.errmsg = json['errmsg']?.toString();
	}
	return data;
}

Map<String, dynamic> baseDateEntityToJson(BaseDateEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['errno'] = entity.errno;
	data['errmsg'] = entity.errmsg;
	return data;
}