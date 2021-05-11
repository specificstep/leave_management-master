import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';
import 'KRAEmployeeListRepository.dart';
import 'KRAEmployeeListResponse.dart';

class KRAEmployeeListBloc {
  final KRAEmployeeListRepository _repository = KRAEmployeeListRepository();
  final BehaviorSubject<ApiResponse<KRAEmployeeListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<KRAEmployeeListResponse>>();

  executeLeaveList(CommonRequest request) {
    _repository.executekraemployeeList(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<KRAEmployeeListResponse>> get subject => _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

