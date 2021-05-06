import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/AllList/AllListCall.dart';
import 'package:flutter_app/Task/AllList/AllListRequest.dart';
import 'package:rxdart/rxdart.dart';

import 'ProjectListCall.dart';
import 'ProjectListResponse.dart';


class ProjectListRepository {
  executeallList(AllListRequest request,
      BehaviorSubject<ApiResponse<ProjectListResponse>> responseSubject) {
    new ProjectListCall(request, responseSubject).execute();
  }

}
