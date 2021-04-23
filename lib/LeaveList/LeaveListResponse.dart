import 'package:flutter_app/LeaveList/LeaveListModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class   LeaveListResponse extends GeneralResponse {
  LeaveListModel Result;

  LeaveListResponse.fromJson(Map<String, dynamic> json)
      : Result = LeaveListModel.fromJson(json),
        super.fromJson(json);
}
