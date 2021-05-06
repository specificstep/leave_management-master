import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';
import 'package:flutter_app/Task/AllList/AllListRequest.dart';


class ProjectListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> projectlist(AllListRequest ListRequest) {
    return networkUtil.post(ApiConstants.ALL_LIST, ListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  ProjectListApiService();
