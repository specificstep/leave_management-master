import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';
import 'CheckInRequest.dart';
/// write your all API Async requests here
class CheckInApiService {
  NetworkUtil networkUtil = NetworkUtil();

  Future<Response> checkin(CheckInRequest checkInRequest) {
    return networkUtil.post(ApiConstants.CHECKIN, checkInRequest.toMap());
  }
}

///Single final Object of API Service
final checkinapiServiceInstance = CheckInApiService();
