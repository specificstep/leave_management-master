import 'package:flutter_app/AttendanceList/AttendanceListCall.dart';
import 'package:flutter_app/AttendanceList/AttendanceListRequest.dart';
import 'package:flutter_app/AttendanceList/AttendanceListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';


class AttendanceListRepository {
  executeAttendanceList(AttendanceListRequest request,
      BehaviorSubject<ApiResponse<AttendanceListResponse>> responseSubject) {
    new AttendanceListCall(request, responseSubject).execute();
  }

}
