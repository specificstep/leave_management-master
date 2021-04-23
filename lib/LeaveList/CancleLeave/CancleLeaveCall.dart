import 'package:dio/dio.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveRequest.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

import 'CancleLeaveApiService.dart';

class CancleLeaveCall extends DataFetchCall<CancleLeaveResponse> {
  CancleLeaveRequest  _request;
  CancleLeaveCall(CancleLeaveRequest  request,
      BehaviorSubject<ApiResponse<CancleLeaveResponse>> responseSubject)
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
    return apiServiceInstance.addcancleleave(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(CancleLeaveResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  CancleLeaveResponse parseJson(Response response) {
    return CancleLeaveResponse.fromJson(response.data);
  }
}
