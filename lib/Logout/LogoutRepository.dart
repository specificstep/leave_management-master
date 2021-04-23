import 'package:flutter_app/AddLeave/AddLeaveCall.dart';
import 'package:flutter_app/AddLeave/AddLeaveRequest.dart';
import 'package:flutter_app/AddLeave/AddLeaveResponse.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListCall.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Logout/LogoutResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'LogoutCall.dart';


class LogoutRepository {

  executlogout(LeaveListRequest request,
      BehaviorSubject<ApiResponse<LogoutResponse>> responseSubject) {
    new LogoutCall(request, responseSubject).execute();
  }

}
