import 'package:flutter_app/LeaveBalance/LeaveBalanceModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class LeaveBalanceListResponse extends GeneralResponse {
  LeaveBalanceModel Result;

  LeaveBalanceListResponse.fromJson(Map<String, dynamic> json)
      : Result = LeaveBalanceModel.fromJson(json),
        super.fromJson(json);
}
