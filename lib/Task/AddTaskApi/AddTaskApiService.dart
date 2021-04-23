import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';
import 'package:flutter_app/Task/AddTaskApi/AddTaskRequest.dart';

class AddTaskApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> alllist(AddTaskRequest ListRequest) {
    return networkUtil.post2(ApiConstants.ADD_TASK, ListRequest.data);
  }

}
final apiServiceInstance =  AddTaskApiService();
