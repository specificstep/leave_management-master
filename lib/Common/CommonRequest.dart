import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class CommonRequest {
  String userid;
  String token;

  CommonRequest(this.userid,this.token);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    print("LeaveListRequest : " + map.toString());
    return map;
  }
}
