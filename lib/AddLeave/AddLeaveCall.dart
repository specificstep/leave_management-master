import 'package:dio/dio.dart';
import 'package:flutter_app/AddLeave/AddLeaveApiService.dart';
import 'package:flutter_app/AddLeave/AddLeaveRequest.dart';
import 'package:flutter_app/AddLeave/AddLeaveResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

class AddLeaveCall extends DataFetchCall<AddLeaveResponse> {
  AddLeaveRequest  _request;
  AddLeaveCall( AddLeaveRequest  request,
      BehaviorSubject<ApiResponse<AddLeaveResponse>> responseSubject)
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
    return apiServiceInstance.addleave(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(AddLeaveResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  AddLeaveResponse parseJson(Response response) {
    return AddLeaveResponse.fromJson(response.data);
  }
}
