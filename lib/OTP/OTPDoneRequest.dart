import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class OTPDoneRequest {
  String mobile;
  String otp;
  String resend;

 OTPDoneRequest(this.mobile,this.otp);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.MOBILE_NO] = mobile;
    map[ApiConstants.OTP] = otp;
    print("mobile: " + map.toString());
    print("otp: " + map.toString());
    return map;
  }
}
