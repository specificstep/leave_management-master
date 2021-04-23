import '../AllApiCall/ApiConstants.dart';

class LoginRequest {
  String mobile;
  String otp;

  LoginRequest(this.mobile);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.MOBILE_NO] = mobile;
    print("LoginRequest : " + map.toString());
    return map;
  }
}
