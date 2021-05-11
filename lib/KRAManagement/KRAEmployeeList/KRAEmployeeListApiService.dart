import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';


class KRAEmployeeListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response>KRAEmployeeList(CommonRequest ListRequest) {
    return networkUtil.post(ApiConstants.KRA_employee, ListRequest.toMap());
  }
}
///Single final Object of API Service
final apiServiceInstance = KRAEmployeeListApiService();
