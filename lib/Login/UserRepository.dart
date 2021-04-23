import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/LoginRequest.dart';
import 'package:flutter_app/Login/LoginResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'LoginCall.dart';

class UserRepository {
  /// create new Call  for getData  and execute the call and post it on given BehaviorSubject.
  /// params 1. request -> request data for api
  /// params 2. BehaviourSubject -> in which data is sinc/post
  executeLogin(LoginRequest request,
      BehaviorSubject<ApiResponse<LoginResponse>> responseSubject) {
    new LoginCall(request, responseSubject).execute();
  }

}
