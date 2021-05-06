import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskRequest.dart';


class ViewTaskApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> viewTask(ViewTaskRequest ListRequest) {
    return networkUtil.post(ApiConstants.VIEW_TASK, ListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  ViewTaskApiService();
