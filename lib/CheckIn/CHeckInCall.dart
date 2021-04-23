import 'package:dio/dio.dart';
import 'package:flutter_app/CheckIn/CheckInApiService.dart';
import 'package:flutter_app/CheckIn/CheckInRequest.dart';
import 'package:flutter_app/OTP/OTPDoneRequest.dart';
import 'package:rxdart/rxdart.dart';

import 'CheckInApiResponse.dart';
import 'CheckInDataFetchCall.dart';
import 'CheckInResponse.dart';


class CHeckInCall extends CheckInDataFetchCall<CheckInResponse> {
  CheckInRequest _request;
  
  CHeckInCall(CheckInRequest request, BehaviorSubject<CheckInApiResponse<CheckInResponse>> responseSubject) : super(responseSubject) {this._request = request;}
  
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
    return checkinapiServiceInstance.checkin(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(CheckInResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  CheckInResponse parseJson(Response response) {
    return CheckInResponse.fromJson(response.data);
  }
}