import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Logout/LogoutRepository.dart';
import 'package:flutter_app/Logout/LogoutResponse.dart';
import 'package:rxdart/rxdart.dart';

class LogoutBloc {
  final LogoutRepository _repository = LogoutRepository();
  final BehaviorSubject<ApiResponse<LogoutResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<LogoutResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executelogout(LeaveListRequest request) {
    _repository.executlogout(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<LogoutResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

