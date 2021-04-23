import 'package:flutter_app/LeaveBalance/LeaveBalanceListCall.dart';
import 'package:flutter_app/LeaveBalance/LeaveBalanceListResponse.dart';
import 'package:flutter_app/LeaveList/LeaveListCall.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveList/LeaveListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';


class LeaveBalanceListRepository {

  executeLeaveBalanceList(LeaveListRequest request,
      BehaviorSubject<ApiResponse<LeaveBalanceListResponse>> responseSubject) {
    new LeaveBalanceListCall(request, responseSubject).execute();
  }

}
