import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'ResendOTPRequest.dart';
import 'ResendOTPResponse.dart';
import 'ResendOtpApiResponse.dart';
import 'ResendOtpApiService.dart';
import 'ResendOtpDataFetchCall.dart';

class ResendOTPCall extends ResendOtpDataFetchCall<ResendOTPResponse> {
  ResendOTPRequest _request;
  
  ResendOTPCall(ResendOTPRequest request, BehaviorSubject<ResendOtpApiResponse<ResendOTPResponse>> responseSubject) : super(responseSubject) {this._request = request;}
  
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
    return resendotpapiServiceInstance.otp(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(ResendOTPResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  ResendOTPResponse parseJson(Response response) {
    return ResendOTPResponse.fromJson(response.data);
  }
}