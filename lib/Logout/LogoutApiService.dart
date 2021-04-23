import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class LogoutApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> addlogout(LeaveListRequest request) {
    return networkUtil.post(ApiConstants.LOGOUT, request.toMap());
  }

}
///Single final Object of API Service
final apiServiceInstance =  LogoutApiService();
