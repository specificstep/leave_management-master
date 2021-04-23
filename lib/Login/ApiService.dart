import 'package:dio/dio.dart';
import 'package:flutter_app/Login/LoginRequest.dart';
import '../AllApiCall/ApiConstants.dart';
import 'NetworkUtil.dart';


/// write your all API Async requests here
class ApiService {
  NetworkUtil networkUtil = NetworkUtil();

  Future<Response> login(LoginRequest loginRequest) {
    return networkUtil.post(ApiConstants.LOGIN, loginRequest.toMap());
  }
}

///Single final Object of API Service
final apiServiceInstance = ApiService();
