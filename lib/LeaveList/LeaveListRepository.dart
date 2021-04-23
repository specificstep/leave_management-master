import 'package:flutter_app/LeaveList/LeaveListCall.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveList/LeaveListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';


class LeaveListRepository {

  executeLeaveList(LeaveListRequest request,
      BehaviorSubject<ApiResponse<LeaveListResponse>> responseSubject) {
    new LeaveListCall(request, responseSubject).execute();
  }

}
