import 'package:flutter_app/KRAManagement/AddKRAApi/KRAManagementRepository.dart';
import 'package:flutter_app/KRAManagement/AddKRAApi/KRAManagementResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'AddKRARequest.dart';


class AddKRABloc {
  final KRAManagementRepository _repository = KRAManagementRepository();
  final BehaviorSubject<ApiResponse<KRAManagementResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<KRAManagementResponse>>();

  executeAttendanceList(AddKRARequest request) {
    _repository.executeAddKRA(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<KRAManagementResponse>> get subject =>
      _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}
