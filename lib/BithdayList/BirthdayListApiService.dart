import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class BirthdayListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> birthdaylist(CommonRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.BIRTHDAYLIST, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  BirthdayListApiService();
