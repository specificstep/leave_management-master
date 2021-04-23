import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class CheckInRequest {
  String userid;
  String check_in_lat;
  String check_in_long;
  String checkin_time;
  String add_date;
  String ip_address;
  String check_in_image;
  String user_connection;
  String checkinout_type;
  String token;

  CheckInRequest(this.userid,this.check_in_lat,this.check_in_long,this.checkin_time,
     this.add_date,this.ip_address,this.check_in_image,this.user_connection,this.checkinout_type,this.token);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKIN_LAT] = check_in_lat;
    map[ApiConstants.CHECKIN_LONG] = check_in_long;
    map[ApiConstants.CHECKIN_TIME] = checkin_time;
    map[ApiConstants.ADD_DATE] = add_date;
    map[ApiConstants.IP_ADDRESS] = ip_address;
    map[ApiConstants.CHECKIN_IMAGE] = check_in_image;
    map[ApiConstants.USER_CONNECTION] = user_connection;
    map[ApiConstants.CHECKINOUT_TYPE] = checkinout_type;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    print("checkin_request: " + map.toString());
    return map;
  }
}
