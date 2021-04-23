import 'package:flutter_app/AttendanceList/AttendanceListModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class AttendanceListResponse extends GeneralResponse {
  AttendanceListModel Result;

  AttendanceListResponse.fromJson(Map<String, dynamic> json)
      : Result = AttendanceListModel.fromJson(json),
        super.fromJson(json);
}
