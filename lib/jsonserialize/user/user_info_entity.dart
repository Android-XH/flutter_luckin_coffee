import 'package:flutter_luckin_coffee/generated/json/base/json_convert_content.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
	UserInfoUserInfo userInfo;
	int expireDate;
	String token;
}

class UserInfoUserInfo with JsonConvert<UserInfoUserInfo> {
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
	UserInfoUserInfoUserLog userLog;
	String introduction;
}

class UserInfoUserInfoUserLog with JsonConvert<UserInfoUserInfoUserLog> {
	double star;
	double good;
	double monthMoney;
	int orderNum;
	int patientNum;
}
