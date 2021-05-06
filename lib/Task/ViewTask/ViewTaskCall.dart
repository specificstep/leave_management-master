import 'package:dio/dio.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskRequest.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskResponse.dart';
import 'package:rxdart/subjects.dart';

import 'ViewTaskApiService.dart';



class ViewTaskCall extends DataFetchCall<ViewTaskResponse> {
  ViewTaskRequest  _request;
  ViewTaskCall(ViewTaskRequest  request,
      BehaviorSubject<ApiResponse<ViewTaskResponse>> responseSubject)
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
    return apiServiceInstance.viewTask(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(ViewTaskResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  ViewTaskResponse parseJson(Response response) {
    return ViewTaskResponse.fromJson(response.data);
  }
}
