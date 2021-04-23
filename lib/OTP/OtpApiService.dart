import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';
import 'package:flutter_app/OTP/OTPDoneRequest.dart';



/// write your all API Async requests here
class OtpApiService {
  NetworkUtil networkUtil = NetworkUtil();

  Future<Response> otp(OTPDoneRequest otpDoneRequest) {
    return networkUtil.post(ApiConstants.LOGIN, otpDoneRequest.toMap());
  }
}

///Single final Object of API Service
final otpapiServiceInstance = OtpApiService();
