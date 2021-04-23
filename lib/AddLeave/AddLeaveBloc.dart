import 'package:flutter_app/AddLeave/AddLeaveRequest.dart';
import 'package:flutter_app/AddLeave/AddLeaveRepository.dart';
import 'package:flutter_app/AddLeave/AddLeaveResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class AddLeaveBloc {
  final AddLeaveRepository _repository = AddLeaveRepository();
  final BehaviorSubject<ApiResponse<AddLeaveResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<AddLeaveResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeAddLeave(AddLeaveRequest request) {
    _repository.executeaddLeave(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<AddLeaveResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

