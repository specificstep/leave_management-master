import 'package:flutter_app/LeaveBalance/LeaveBalanceListRepository.dart';
import 'package:flutter_app/LeaveBalance/LeaveBalanceListResponse.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class LeaveBalanceListBloc {
  final LeaveBalanceListRepository _repository = LeaveBalanceListRepository();
  final BehaviorSubject<ApiResponse<LeaveBalanceListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<LeaveBalanceListResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeLeaveBalanceList(LeaveListRequest request) {
    _repository.executeLeaveBalanceList(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<LeaveBalanceListResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

