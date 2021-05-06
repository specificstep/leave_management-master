import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskRequest.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'ViewTaskCall.dart';


class ViewTaskRepository {
  executeViewTask(ViewTaskRequest request,
      BehaviorSubject<ApiResponse<ViewTaskResponse>> responseSubject) {
    new ViewTaskCall(request, responseSubject).execute();
  }

}
