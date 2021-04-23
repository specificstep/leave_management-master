import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/AddTaskApi/AddTaskRequest.dart';
import 'package:flutter_app/Task/AddTaskApi/AddTaskResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'AddTaskCall.dart';

class AddTaskRepository {
  executeaddTask(AddTaskRequest request,
      BehaviorSubject<ApiResponse<AddTaskResponse>> responseSubject) {
    new AddTaskCall(request, responseSubject).execute();
  }

}
