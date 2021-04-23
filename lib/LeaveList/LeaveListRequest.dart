import '../AllApiCall/ApiConstants.dart';

class LeaveListRequest {
  String userid;
  String token;

  LeaveListRequest(this.userid,this.token);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    print("LeaveListRequest : " + map.toString());
    return map;
  }
}
