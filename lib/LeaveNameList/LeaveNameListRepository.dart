import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListCall.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';


class LeaveNameListRepository {

  executeLeaveNameList(LeaveListRequest request,
      BehaviorSubject<ApiResponse<LeaveNameListResponse>> responseSubject) {
    new LeaveNameListCall(request, responseSubject).execute();
  }

}
