import 'package:flutter_app/AddLeave/AddLeaveCall.dart';
import 'package:flutter_app/AddLeave/AddLeaveRequest.dart';
import 'package:flutter_app/AddLeave/AddLeaveResponse.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListCall.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';


class AddLeaveRepository {

  executeaddLeave(AddLeaveRequest request,
      BehaviorSubject<ApiResponse<AddLeaveResponse>> responseSubject) {
    new AddLeaveCall(request, responseSubject).execute();
  }

}
