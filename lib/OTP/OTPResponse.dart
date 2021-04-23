import 'package:flutter_app/Login/GeneralResponse.dart';
import 'package:flutter_app/Login/User.dart';

class OTPResponse extends GeneralResponse {
  User Result;

  OTPResponse.fromJson(Map<String, dynamic> json)
      : Result = User.fromJson(json),
        super.fromJson(json);

}
