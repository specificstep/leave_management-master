import 'package:dio/dio.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveModel.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class ManageLEaveApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> ManageLeaveList(CommonRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.ALLMEMBER_LEAVELIST, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  ManageLEaveApiService();
