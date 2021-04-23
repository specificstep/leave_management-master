import 'package:flutter_app/AddLeave/AddLeaveModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class LogoutResponse extends GeneralResponse {
  AddLeaveModel Result;

  LogoutResponse.fromJson(Map<String, dynamic> json)
      : Result = AddLeaveModel.fromJson(json),
        super.fromJson(json);
}
