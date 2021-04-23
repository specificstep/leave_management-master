import 'package:flutter_app/Login/GeneralResponse.dart';
import 'package:flutter_app/Login/User.dart';

class ViewTaskResponse extends GeneralResponse {
  User Result;

  ViewTaskResponse.fromJson(Map<String, dynamic> json)
      : Result = User.fromJson(json),
        super.fromJson(json);

}
