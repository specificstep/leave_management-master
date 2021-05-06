import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class ViewTaskRequest {
  String userid;
  String token;
  String task_userid;

 ViewTaskRequest(this.userid,this.token,this.task_userid);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    map["task_userid"] = task_userid;

    print(map.toString());
    return map;
  }
}
