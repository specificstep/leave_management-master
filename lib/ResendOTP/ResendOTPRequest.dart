import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class ResendOTPRequest {
  String mobile;
  String resend;

  ResendOTPRequest(this.mobile,this.resend);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.MOBILE_NO] = mobile;
    map[ApiConstants.RESEND] = resend;
    print("ResendOTPRequest : " + map.toString());
    return map;
  }
}
