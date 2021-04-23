import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

import 'CheckInOutStatusRequest.dart';

/// write your all API Async requests here
class CheckInOutStatusApiService {
  NetworkUtil networkUtil = NetworkUtil();

  Future<Response> checkout(CheckInOutStatusRequest checkInOutStatusRequest) {
    return networkUtil.post(ApiConstants.CHECKINOUTSTATUS, checkInOutStatusRequest.toMap());
  }
}

///Single final Object of API Service
final checkoutapiServiceInstance = CheckInOutStatusApiService();
