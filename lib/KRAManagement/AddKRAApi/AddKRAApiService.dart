import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

import 'AddKRARequest.dart';

class AddKRAApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> addKRA(AddKRARequest addKRARequest) {
    return networkUtil.post(ApiConstants.ADD_KRA, addKRARequest.toMap());
  }

}

///Single final Object of API Service
final addkraapiServiceInstance =  AddKRAApiService();
