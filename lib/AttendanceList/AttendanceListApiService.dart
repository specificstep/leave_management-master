import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/AttendanceList/AttendanceListRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class AttendanceListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> attendancelist(AttendanceListRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.ATTENDANCELIST, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final atendanceapiServiceInstance =  AttendanceListApiService();
