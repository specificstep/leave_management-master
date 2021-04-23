import 'package:dio/dio.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:flutter_app/Task/AddTaskApi/AddTaskRequest.dart';
import 'package:flutter_app/Task/AddTaskApi/AddTaskResponse.dart';
import 'package:rxdart/subjects.dart';

import 'AddTaskApiService.dart';


class AddTaskCall extends DataFetchCall<AddTaskResponse> {
  AddTaskRequest  _request;
  AddTaskCall(AddTaskRequest  request,
      BehaviorSubject<ApiResponse<AddTaskResponse>> responseSubject)
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
    return apiServiceInstance.alllist(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(AddTaskResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  AddTaskResponse parseJson(Response response) {
    return AddTaskResponse.fromJson(response.data);
  }
}
