import 'package:flutter_app/Admin/ManageLeave/ManageLeaveModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class   ManageLeaveResponse extends GeneralResponse {
  ManageLeaveModel Result;

  ManageLeaveResponse.fromJson(Map<String, dynamic> json)
      : Result = ManageLeaveModel.fromJson(json),
        super.fromJson(json);
}
