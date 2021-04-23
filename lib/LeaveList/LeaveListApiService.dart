import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class LeaveListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> leavelist(LeaveListRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.LEAVELIST, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  LeaveListApiService();
