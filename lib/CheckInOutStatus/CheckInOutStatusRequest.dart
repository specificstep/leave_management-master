import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class CheckInOutStatusRequest {
  String userid;
  String token;

  CheckInOutStatusRequest(this.userid,this.token);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    print("checkin_request: " + map.toString());
    return map;
  }
}
