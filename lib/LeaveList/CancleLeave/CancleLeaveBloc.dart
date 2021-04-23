import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveRepository.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveRequest.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class CancleLeaveBloc {
  final CancleLeaveRepository _repository = CancleLeaveRepository();
  final BehaviorSubject<ApiResponse<CancleLeaveResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<CancleLeaveResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executecancleLeave(CancleLeaveRequest request) {
    _repository.executecancleleave(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<CancleLeaveResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

