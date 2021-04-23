import 'package:flutter_app/Common/CommonModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class   AddTaskResponse extends GeneralResponse {
  CommonModel Result;

  AddTaskResponse.fromJson(Map<String, dynamic> json)
      : Result = CommonModel.fromJson(json),
        super.fromJson(json);
}
