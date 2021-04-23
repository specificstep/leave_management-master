import 'package:dio/dio.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

import 'LeaveNameListApiService.dart';


class LeaveNameListCall extends DataFetchCall<LeaveNameListResponse> {
  LeaveListRequest  _request;
  LeaveNameListCall( LeaveListRequest  request,
      BehaviorSubject<ApiResponse<LeaveNameListResponse>> responseSubject)
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
    return apiServiceInstance.leaveNamelist(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(LeaveNameListResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  LeaveNameListResponse parseJson(Response response) {
    return LeaveNameListResponse.fromJson(response.data);
  }
}
