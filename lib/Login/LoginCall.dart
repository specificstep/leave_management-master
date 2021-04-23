import 'package:dio/dio.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/ApiService.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:flutter_app/Login/LoginRequest.dart';
import 'package:flutter_app/Login/LoginResponse.dart';

import 'package:rxdart/rxdart.dart';

class LoginCall extends DataFetchCall<LoginResponse> {
  LoginRequest _request;

  LoginCall(LoginRequest request, BehaviorSubject<ApiResponse<LoginResponse>> responseSubject) : super(responseSubject) {this._request = request;}

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
    return apiServiceInstance.login(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(LoginResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  LoginResponse parseJson(Response response) {
    return LoginResponse.fromJson(response.data);
  }
}