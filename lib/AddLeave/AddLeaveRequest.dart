import '../AllApiCall/ApiConstants.dart';

class AddLeaveRequest {
  String userid;
  String token;
  String type;
  String start_date;
  String end_date;
  String select_all;
  String dayof_leave_array;
  String resion;

  AddLeaveRequest(this.userid, this.token, this.type, this.start_date,
      this.end_date, this.select_all, this.dayof_leave_array, this.resion);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    map[ApiConstants.TYPE] = type;
    map[ApiConstants.START_DATE] = start_date;
    map[ApiConstants.END_DATE] = end_date;
    map[ApiConstants.SELECT_ALL] = select_all;
    map[ApiConstants.DAY_OF_LEAVE] = dayof_leave_array;
    map[ApiConstants.REASON] = resion;

    print("AddLeaveRequest : " + map.toString());

    return map;
  }
}
