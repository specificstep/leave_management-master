import 'package:dio/dio.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:flutter_app/Logout/LogoutResponse.dart';
import 'package:rxdart/subjects.dart';

import 'LogoutApiService.dart';

class LogoutCall extends DataFetchCall<LogoutResponse> {
  LeaveListRequest  _request;
  LogoutCall( LeaveListRequest  request,
      BehaviorSubject<ApiResponse<LogoutResponse>> responseSubject)
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
    return apiServiceInstance.addlogout(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(LogoutResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  LogoutResponse parseJson(Response response) {
    return LogoutResponse.fromJson(response.data);
  }
}
