import 'package:dio/dio.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:flutter_app/Task/AllList/AllListRequest.dart';
import 'package:flutter_app/Task/ProjectList/ProjectListResponse.dart';
import 'package:rxdart/subjects.dart';

import 'ProjectListApiService.dart';



class ProjectListCall extends DataFetchCall<ProjectListResponse> {
  AllListRequest  _request;
  ProjectListCall(AllListRequest  request,
      BehaviorSubject<ApiResponse<ProjectListResponse>> responseSubject)
      : super(responseSubject) {
    this._request = request;
  }

  /// if return false then createApiAsyc is called
  /// if return true then loadFromDB Function  is called
  @override
  bool shouldFetchFromDB() {
    return false;
  }

  /// called when shouldFetchfromDB() is returning true
  @override
  void loadFromDB() {
    ///  get data from DB todo post/sinc on behaviourSubject after
  }

  /// called when shouldFetchfromDB() is returning false

  @override
  Future<Response> createApiAsync() {
    /// need to return APIService async task for API request
    return apiServiceInstance.projectlist(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(ProjectListResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  ProjectListResponse parseJson(Response response) {
    return ProjectListResponse.fromJson(response.data);
  }
}
