import 'package:dio/dio.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveResponse.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

import 'ManageLEaveApiService.dart';


class ManageLeaveCall extends DataFetchCall<ManageLeaveResponse> {
  CommonRequest  _request;
  ManageLeaveCall(CommonRequest  request,
      BehaviorSubject<ApiResponse<ManageLeaveResponse>> responseSubject)
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
    return apiServiceInstance.ManageLeaveList(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(ManageLeaveResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  ManageLeaveResponse parseJson(Response response) {
    return ManageLeaveResponse.fromJson(response.data);
  }
}
