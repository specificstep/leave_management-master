import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class CancleLeaveApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> addcancleleave(CancleLeaveRequest request) {
    return networkUtil.post(ApiConstants.CANCLELEAVE, request.toMap());
  }

}
///Single final Object of API Service
final apiServiceInstance =  CancleLeaveApiService();
