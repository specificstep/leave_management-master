import 'package:flutter_app/KRAManagement/KRAEmployeeList/KRAEmployeeListModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class   KRAEmployeeListResponse extends GeneralResponse {
  KRAEmployeeListModel Result;

  KRAEmployeeListResponse.fromJson(Map<String, dynamic> json)
      : Result = KRAEmployeeListModel.fromJson(json),
        super.fromJson(json);
}
