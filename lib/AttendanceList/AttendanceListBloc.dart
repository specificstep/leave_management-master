import 'package:flutter_app/AttendanceList/AttendanceListRepository.dart';
import 'package:flutter_app/AttendanceList/AttendanceListRequest.dart';
import 'package:flutter_app/AttendanceList/AttendanceListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class AttendanceListBloc {
  final AttendanceListRepository _repository = AttendanceListRepository();
  final BehaviorSubject<ApiResponse<AttendanceListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<AttendanceListResponse>>();

  executeAttendanceList(AttendanceListRequest request) {
    _repository.executeAttendanceList(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<AttendanceListResponse>> get subject =>
      _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}
