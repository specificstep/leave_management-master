import 'package:dio/dio.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectRequest.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

import 'ApproveOrRejectApiService.dart';



class ApproveOrRejectCall extends DataFetchCall<ApproveOrRejectResponse> {
  ApproveOrRejectRequest  _request;
  ApproveOrRejectCall(ApproveOrRejectRequest  request,
      BehaviorSubject<ApiResponse<ApproveOrRejectResponse>> responseSubject)
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
    return apiServiceInstance.ApproveOrReject(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(ApproveOrRejectResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  ApproveOrRejectResponse parseJson(Response response) {
    return ApproveOrRejectResponse.fromJson(response.data);
  }
}
