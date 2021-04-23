import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

import 'CheckOutRequest.dart';
/// write your all API Async requests here
class CheckOutApiService {
  NetworkUtil networkUtil = NetworkUtil();

  Future<Response> checkout(CheckOutRequest checkoutRequest) {
    return networkUtil.post(ApiConstants.CHECKIN, checkoutRequest.toMap());
  }
}

///Single final Object of API Service
final checkoutapiServiceInstance = CheckOutApiService();
