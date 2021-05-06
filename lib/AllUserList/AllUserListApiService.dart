import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/AttendanceList/AttendanceListRequest.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class AllUserListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> alluserlist(CommonRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.AllUserLIst, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final atendanceapiServiceInstance =  AllUserListApiService();
