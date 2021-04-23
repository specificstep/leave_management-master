import 'package:dio/dio.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectRequest.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveModel.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

class ApproveOrRejectApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> ApproveOrReject(ApproveOrRejectRequest leaveListRequest) {
    return networkUtil.post(ApiConstants.ADMINLEAVE_APPROVAL, leaveListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  ApproveOrRejectApiService();
