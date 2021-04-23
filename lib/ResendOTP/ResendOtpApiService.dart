import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';
import 'package:flutter_app/ResendOTP/ResendOTPRequest.dart';

class ResendOtpApiService {
  NetworkUtil networkUtil = NetworkUtil();

  Future<Response> otp(ResendOTPRequest resendOTPRequest) {
    return networkUtil.post(ApiConstants.LOGIN, resendOTPRequest.toMap());
  }
}

///Single final Object of API Service
final resendotpapiServiceInstance = ResendOtpApiService();
