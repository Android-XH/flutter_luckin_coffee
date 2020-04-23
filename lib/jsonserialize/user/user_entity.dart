import 'package:flutter_luckin_coffee/generated/json/base/json_convert_content.dart';

class UserEntity with JsonConvert<UserEntity> {
	UserUserInfo userInfo;
	int expireDate;
	String token;
}

class UserUserInfo with JsonConvert<UserUserInfo> {
	int id;
	String doctorName;
	String departmentName;
	String categoryName;
	String organName;
	String nickName;
	String avatarUrl;
	String mobile;
	int gender;
	String imUsername;
	String imPass;
	bool isRegister;
	String isAuth;
	bool isPrescription;
	UserUserInfoUserLog userLog;
	String introduction;
}

class UserUserInfoUserLog with JsonConvert<UserUserInfoUserLog> {
	int star;
	int good;
	double monthMoney;
	int orderNum;
	int patientNum;
}
