import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectCall.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectRequest.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectResponse.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveCall.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class ApproveOrRejectRepository {
  executApproveOrReject(ApproveOrRejectRequest request,
      BehaviorSubject<ApiResponse<ApproveOrRejectResponse>> responseSubject) {
    new ApproveOrRejectCall(request, responseSubject).execute();
  }

}
