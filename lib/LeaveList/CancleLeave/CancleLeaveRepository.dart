import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveCall.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveRequest.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveResponse.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Logout/LogoutResponse.dart';
import 'package:rxdart/rxdart.dart';

class CancleLeaveRepository {

  executecancleleave(CancleLeaveRequest request,
      BehaviorSubject<ApiResponse<CancleLeaveResponse>> responseSubject) {
    new CancleLeaveCall(request, responseSubject).execute();
  }

}
