import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskRepository.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskRequest.dart';
import 'package:rxdart/rxdart.dart';

import 'ViewTaskResponse.dart';

class ViewTaskBloc {
  final ViewTaskRepository _repository = ViewTaskRepository();
  final BehaviorSubject<ApiResponse<ViewTaskResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<ViewTaskResponse>>();

  executeLeaveList(ViewTaskRequest request) {
    _repository.executeViewTask(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<ViewTaskResponse>> get subject => _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

