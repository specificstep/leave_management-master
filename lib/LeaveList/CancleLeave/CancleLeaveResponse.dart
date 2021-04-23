import 'package:flutter_app/Common/CommonModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class CancleLeaveResponse extends GeneralResponse {
  CommonModel Result;

  CancleLeaveResponse.fromJson(Map<String, dynamic> json)
      : Result = CommonModel.fromJson(json),
        super.fromJson(json);
}
