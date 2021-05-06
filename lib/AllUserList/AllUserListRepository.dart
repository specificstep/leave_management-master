import 'package:flutter_app/AllUserList/AllUserListResponse.dart';
import 'package:flutter_app/AttendanceList/AttendanceListCall.dart';
import 'package:flutter_app/AttendanceList/AttendanceListRequest.dart';
import 'package:flutter_app/AttendanceList/AttendanceListResponse.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'AllUserListCall.dart';


class AllUserListRepository {
  executeAllUserList(CommonRequest request,
      BehaviorSubject<ApiResponse<AllUserListResponse>> responseSubject) {
    new AllUseristCall(request, responseSubject).execute();
  }

}
