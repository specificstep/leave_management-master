import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class LeaveNameListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> leaveNamelist(LeaveListRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.LEAVENAMELIST, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  LeaveNameListApiService();
