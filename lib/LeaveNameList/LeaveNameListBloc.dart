import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListRepository.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class LeaveNameListBloc {
  final LeaveNameListRepository _repository = LeaveNameListRepository();
  final BehaviorSubject<ApiResponse<LeaveNameListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<LeaveNameListResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeLeaveNameList(LeaveListRequest request) {
    _repository.executeLeaveNameList(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<LeaveNameListResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

