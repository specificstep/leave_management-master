import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class AllListRequest {
  String userid;
  String token;
  String project_id;

  AllListRequest(this.userid,this.token,this.project_id);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    map["project_id"] = project_id;
    print("AllListRequest : " + map.toString());
    return map;
  }
}
