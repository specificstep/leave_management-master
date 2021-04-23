import 'package:flutter_app/BithdayList/BirthdayListRepository.dart';
import 'package:flutter_app/BithdayList/BirthdayListResponse.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class BirthdayListBloc {
  final BirthdayListRepository _repository = BirthdayListRepository();
  final BehaviorSubject<ApiResponse<BirthdayListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<BirthdayListResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeLeaveList(CommonRequest request) {
    _repository.executeBirthdayList(request, _subjectLogin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<BirthdayListResponse>> get subject => _subjectLogin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

