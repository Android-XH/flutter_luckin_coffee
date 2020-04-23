import 'package:flutter_luckin_coffee/jsonserialize/user/user_entity.dart';
import 'package:flutter_luckin_coffee/utils/LogUtil.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['userInfo'] != null) {
		data.userInfo = new UserUserInfo().fromJson(json['userInfo']);
		LogUtil.e('转换userInfo$data');
	}
	if (json['expireDate'] != null) {
		data.expireDate = json['expireDate']?.toInt();
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.userInfo != null) {
		data['userInfo'] = entity.userInfo.toJson();
	}
	data['expireDate'] = entity.expireDate;
	data['token'] = entity.token;
	return data;
}

userUserInfoFromJson(UserUserInfo data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['doctorName'] != null) {
		data.doctorName = json['doctorName']?.toString();
	}
	if (json['departmentName'] != null) {
		data.departmentName = json['departmentName']?.toString();
	}
	if (json['categoryName'] != null) {
		data.categoryName = json['categoryName']?.toString();
	}
	if (json['organName'] != null) {
		data.organName = json['organName']?.toString();
	}
	if (json['nickName'] != null) {
		data.nickName = json['nickName']?.toString();
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl']?.toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile']?.toString();
	}
	if (json['gender'] != null) {
		data.gender = json['gender']?.toInt();
	}
	if (json['imUsername'] != null) {
		data.imUsername = json['imUsername']?.toString();
	}
	if (json['imPass'] != null) {
		data.imPass = json['imPass']?.toString();
	}
	if (json['isRegister'] != null) {
		data.isRegister = json['isRegister'];
	}
	if (json['isAuth'] != null) {
		data.isAuth = json['isAuth']?.toString();
	}
	if (json['isPrescription'] != null) {
		data.isPrescription = json['isPrescription'];
	}
	if (json['userLog'] != null) {
		data.userLog = new UserUserInfoUserLog().fromJson(json['userLog']);
	}
	if (json['introduction'] != null) {
		data.introduction = json['introduction']?.toString();
	}
	return data;
}

Map<String, dynamic> userUserInfoToJson(UserUserInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['doctorName'] = entity.doctorName;
	data['departmentName'] = entity.departmentName;
	data['categoryName'] = entity.categoryName;
	data['organName'] = entity.organName;
	data['nickName'] = entity.nickName;
	data['avatarUrl'] = entity.avatarUrl;
	data['mobile'] = entity.mobile;
	data['gender'] = entity.gender;
	data['imUsername'] = entity.imUsername;
	data['imPass'] = entity.imPass;
	data['isRegister'] = entity.isRegister;
	data['isAuth'] = entity.isAuth;
	data['isPrescription'] = entity.isPrescription;
	if (entity.userLog != null) {
		data['userLog'] = entity.userLog.toJson();
	}
	data['introduction'] = entity.introduction;
	return data;
}

userUserInfoUserLogFromJson(UserUserInfoUserLog data, Map<String, dynamic> json) {
	if (json['star'] != null) {
		data.star = json['star']?.toInt();
	}
	if (json['good'] != null) {
		data.good = json['good']?.toInt();
	}
	if (json['monthMoney'] != null) {
		data.monthMoney = json['monthMoney']?.toDouble();
	}
	if (json['orderNum'] != null) {
		data.orderNum = json['orderNum']?.toInt();
	}
	if (json['patientNum'] != null) {
		data.patientNum = json['patientNum']?.toInt();
	}
	return data;
}

Map<String, dynamic> userUserInfoUserLogToJson(UserUserInfoUserLog entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['star'] = entity.star;
	data['good'] = entity.good;
	data['monthMoney'] = entity.monthMoney;
	data['orderNum'] = entity.orderNum;
	data['patientNum'] = entity.patientNum;
	return data;
}