import 'package:flutter_app/Admin/ManageLeave/ManageLeaveRepository.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'ManageLeaveResponse.dart';

class ManageLeaveBloc {
  final ManageLeaveRepository _repository = ManageLeaveRepository();
  final BehaviorSubject<ApiResponse<ManageLeaveResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<ManageLeaveResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeLeaveList(CommonRequest request) {
    _repository.executeManageLeave(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<ManageLeaveResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

