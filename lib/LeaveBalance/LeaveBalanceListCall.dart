import 'package:dio/dio.dart';
import 'package:flutter_app/LeaveBalance/LeaveBalanceListApiService.dart';
import 'package:flutter_app/LeaveBalance/LeaveBalanceListResponse.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';


class LeaveBalanceListCall extends DataFetchCall<LeaveBalanceListResponse> {
  LeaveListRequest  _request;
  LeaveBalanceListCall( LeaveListRequest  request,
      BehaviorSubject<ApiResponse<LeaveBalanceListResponse>> responseSubject)
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
    return apiServiceInstance.leavebalancelist(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(LeaveBalanceListResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  LeaveBalanceListResponse parseJson(Response response) {
    return LeaveBalanceListResponse.fromJson(response.data);
  }
}
