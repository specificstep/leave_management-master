import 'package:flutter_app/LeaveList/LeaveListRepository.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveList/LeaveListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class LeaveListBloc {
  final LeaveListRepository _repository = LeaveListRepository();
  final BehaviorSubject<ApiResponse<LeaveListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<LeaveListResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeLeaveList(LeaveListRequest request) {
    _repository.executeLeaveList(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<LeaveListResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

