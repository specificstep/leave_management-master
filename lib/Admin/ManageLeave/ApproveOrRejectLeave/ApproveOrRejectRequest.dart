import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class ApproveOrRejectRequest {
  String userid;
  String token;
  String leave_id;
  String user_leave_id;
  String leave_status;
  String leave_type;
  String remark;


  ApproveOrRejectRequest(this.userid, this.token, this.leave_id,
      this.user_leave_id, this.leave_status, this.leave_type,this.remark);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    map["leave_id"] = leave_id;
    map["user_leave_id"] = user_leave_id;
    map["leave_status"] = leave_status;
    map["leave_type"] = leave_type;
    map["remark"] = remark;

    print("ApproveOrRejectRequest : " + map.toString());
    return map;
  }
}
