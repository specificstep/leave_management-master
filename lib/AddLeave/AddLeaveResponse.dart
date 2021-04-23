import 'package:flutter_app/AddLeave/AddLeaveModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class AddLeaveResponse extends GeneralResponse {
  AddLeaveModel Result;

  AddLeaveResponse.fromJson(Map<String, dynamic> json)
      : Result = AddLeaveModel.fromJson(json),
        super.fromJson(json);
}
