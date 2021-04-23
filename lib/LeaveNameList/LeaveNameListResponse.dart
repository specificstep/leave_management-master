import 'package:flutter_app/LeaveBalance/LeaveBalanceModel.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class LeaveNameListResponse extends GeneralResponse {
  LeaveNameListModel Result;

  LeaveNameListResponse.fromJson(Map<String, dynamic> json)
      : Result = LeaveNameListModel.fromJson(json),
        super.fromJson(json);
}
