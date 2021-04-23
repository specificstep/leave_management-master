import 'package:dio/dio.dart';
import 'package:flutter_app/AddLeave/AddLeaveRequest.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class AddLeaveApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> addleave(AddLeaveRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.ADDLEAVE, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  AddLeaveApiService();
