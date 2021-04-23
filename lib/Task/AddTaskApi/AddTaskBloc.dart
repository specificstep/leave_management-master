import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/AddTaskApi/AddTaskRepository.dart';
import 'package:flutter_app/Task/AddTaskApi/AddTaskResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'AddTaskRequest.dart';

class AddTaskBloc {
  final AddTaskRepository _repository = AddTaskRepository();
  final BehaviorSubject<ApiResponse<AddTaskResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<AddTaskResponse>>();

  executeLeaveList(AddTaskRequest request) {
    _repository.executeaddTask(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<AddTaskResponse>> get subject => _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

