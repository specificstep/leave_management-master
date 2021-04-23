import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class CheckOutRequest {
  String userid;
  String check_out_lat;
  String check_out_long;
  String checkout_time;
  String update_date;
  String ip_address;
  String check_out_image;
  String user_connection;
  String checkinout_type;
  String token;

  CheckOutRequest(this.userid,this.check_out_lat,this.check_out_long,this.checkout_time,
     this.update_date,this.ip_address,this.check_out_image,this.user_connection,this.checkinout_type,this.token);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKOUT_LAT] = check_out_lat;
    map[ApiConstants.CHECKOUT_LONG] = check_out_long;
    map[ApiConstants.CHECKOUT_TIME] = checkout_time;
    map[ApiConstants.UPDATE_DATE] = update_date;
    map[ApiConstants.IP_ADDRESS] = ip_address;
    map[ApiConstants.CHECKOUT_IMAGE] = check_out_image;
    map[ApiConstants.USER_CONNECTION] = user_connection;
    map[ApiConstants.CHECKINOUT_TYPE] = checkinout_type;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    print("checkin_request: " + map.toString());
    return map;
  }
}
