import 'package:flutter_app/Admin/ManageLeave/ManageLeaveCall.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveResponse.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class ManageLeaveRepository {
  executeManageLeave(CommonRequest request,
      BehaviorSubject<ApiResponse<ManageLeaveResponse>> responseSubject) {
    new ManageLeaveCall(request, responseSubject).execute();
  }

}
