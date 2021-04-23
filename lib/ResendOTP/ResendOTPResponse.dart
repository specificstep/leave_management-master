import 'package:flutter_app/Login/GeneralResponse.dart';
import 'package:flutter_app/Login/User.dart';

class ResendOTPResponse extends GeneralResponse {
  User Result;

  ResendOTPResponse.fromJson(Map<String, dynamic> json)
      : Result = User.fromJson(json),
        super.fromJson(json);

}
