
import 'package:flutter_app/Login/User.dart';
import 'GeneralResponse.dart';

class LoginResponse extends GeneralResponse {
  User Result;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : Result = User.fromJson(json),
        super.fromJson(json);

}
