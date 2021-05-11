import 'package:dio/dio.dart';

import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

import 'AddKRAApiService.dart';
import 'AddKRARequest.dart';
import 'KRAManagementResponse.dart';


class AddKRACall extends DataFetchCall<KRAManagementResponse> {
  AddKRARequest  _request;
  AddKRACall(AddKRARequest  request,
      BehaviorSubject<ApiResponse<KRAManagementResponse>> responseSubject)
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
    return addkraapiServiceInstance.addKRA(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(KRAManagementResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  KRAManagementResponse parseJson(Response response) {
    return KRAManagementResponse.fromJson(response.data);
  }
}
