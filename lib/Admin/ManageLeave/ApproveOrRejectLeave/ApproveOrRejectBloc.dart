import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectRepository.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectRequest.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class ApproveOrRejectBloc {
  final ApproveOrRejectRepository _repository = ApproveOrRejectRepository();
  final BehaviorSubject<ApiResponse<ApproveOrRejectResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<ApproveOrRejectResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeApproveOrRejectApi(ApproveOrRejectRequest request) {
    _repository.executApproveOrReject(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<ApproveOrRejectResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

