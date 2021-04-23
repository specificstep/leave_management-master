import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class LeaveBalanceListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> leavebalancelist(LeaveListRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.LEAVEBALANCE, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  LeaveBalanceListApiService();
