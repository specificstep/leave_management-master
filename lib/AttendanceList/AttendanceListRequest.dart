import '../AllApiCall/ApiConstants.dart';

class AttendanceListRequest {
  String userid;
  String token;
  String start_time;
  String end_time;

  AttendanceListRequest(this.userid,this.token,this.start_time,this.end_time);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    map[ApiConstants.START_TIME] = start_time;
    map[ApiConstants.END_TIME] = end_time;
    print("AttendanceListRequest : " + map.toString());
    return map;
  }
}
