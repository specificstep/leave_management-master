import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class CancleLeaveRequest {
  String userid;
  String token;
  String leaveid;

  CancleLeaveRequest(this.userid,this.token,this.leaveid);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    map[ApiConstants.LEAVEID] = leaveid;
    print("CancleLeaveRequest : " + map.toString());
    return map;
  }
}
