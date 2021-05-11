import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  //base_url test
  // static final String BASE_URL = "http://192.168.30.11:8040/pms/webservice/";

  //Live url
  // static final String BASE_URL = "http://petacodes.com/payroll/webservice/";
  static final String BASE_URL = "http://petacodes.com/payroll_dev/webservice/";

  //login
  static final String LOGIN = "login.php";

  // check in/out
  static final String CHECKIN = "checkin_checkout.php";

  //check in/out status
  static final String CHECKINOUTSTATUS = "check_status.php";

// leavelist
  static final String LEAVELIST = "user_leave_list.php";

// leavelbalance
  static final String LEAVEBALANCE = "user_leave_balance.php";

// Attendancelist
  static final String ATTENDANCELIST = "user_attendance_list.php";

  // leavetitle list
  static final String LEAVENAMELIST = "leavename_list.php";

  // birthday list
  static final String BIRTHDAYLIST = "birthday_list.php";

  // add leave
  static final String ADDLEAVE = "add_leave.php";

  // cancle leave
  static final String CANCLELEAVE = "cancle_leave.php";

  // logout
  static final String LOGOUT = "logout.php";

  // all_member_leave_list
  static final String ALLMEMBER_LEAVELIST = "all_member_leave_list.php";

  // admin_leave_approval_reject
  static final String ADMINLEAVE_APPROVAL = "admin_leave_approval_reject.php";

  // all_list
  static final String ALL_LIST = "employee_list.php";

  // all_list
  static final String ADD_TASK = "add_task.php";

  // all user list
  static final String AllUserLIst = "user_list.php";

// View TAsk
  static final String VIEW_TASK = "view_task.php";


// kra_employee
  static final String KRA_employee = "kra_employee_list.php";



// Add KRA
  static final String ADD_KRA = "add_kra.php";

  // mobile number
  static final String MOBILE_NO = "mobile";

  //otp
  static final String OTP = "otp";
  static final String RESEND = "resend";

  //check in
  static final String USERID = "userid";
  static final String CHECKIN_LAT = "check_in_lat";
  static final String CHECKIN_LONG = "check_in_long";
  static final String CHECKIN_TIME = "checkin_time";
  static final String ADD_DATE = "add_date";
  static final String IP_ADDRESS = "ip_address";
  static final String CHECKIN_IMAGE = "check_in_image";
  static final String USER_CONNECTION = "user_connection";
  static final String CHECKINOUT_TYPE = "type";
  static final String CHECKINOUT_TOKEN = "token";

  //checkout

  static final String CHECKOUT_LAT = "check_out_lat";
  static final String CHECKOUT_LONG = "check_out_long";
  static final String CHECKOUT_TIME = "checkout_time";
  static final String UPDATE_DATE = "update_date";
  static final String CHECKOUT_IMAGE = "check_out_image";

  // attendance list0
  static final String START_TIME = "start_time";
  static final String END_TIME = "end_time";

  // for shared preferance
  static final String show_firsttime = "show_firsttime";
  static final String loggedin = "loggedin";
  static final String check_inout_status = "check_in";
  static final String user_id = "1";
  static final String token = "token";
  static final String username = "username";
  static final String rolename = "rolename";

  // add leave
  static final String TYPE = "type";
  static final String START_DATE = "start_date";
  static final String END_DATE = "end_date";
  static final String SELECT_ALL = "select_all";
  static final String DAY_OF_LEAVE = "dayof_leave_array";
  static final String REASON = "resion";

  // cancle leave

  static final String LEAVEID = "leaveid";
  static  String clickeduser_id = "";
}
