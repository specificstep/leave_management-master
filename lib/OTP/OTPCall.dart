import 'package:dio/dio.dart';
import 'package:flutter_app/OTP/OTPDoneRequest.dart';
import 'package:rxdart/rxdart.dart';

import 'OTPResponse.dart';
import 'OtpApiResponse.dart';
import 'OtpApiService.dart';
import 'OtpDataFetchCall.dart';

class OTPCall extends OtpDataFetchCall<OTPResponse> {
  OTPDoneRequest _request;
  
  OTPCall(OTPDoneRequest request, BehaviorSubject<OtpApiResponse<OTPResponse>> responseSubject) : super(responseSubject) {this._request = request;}
  
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
    return otpapiServiceInstance.otp(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(OTPResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  OTPResponse parseJson(Response response) {
    return OTPResponse.fromJson(response.data);
  }
}