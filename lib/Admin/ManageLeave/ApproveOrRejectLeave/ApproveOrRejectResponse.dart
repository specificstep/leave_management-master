import 'package:flutter_app/Admin/ManageLeave/ManageLeaveModel.dart';
import 'package:flutter_app/Common/CommonModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class   ApproveOrRejectResponse extends GeneralResponse {
  CommonModel Result;

  ApproveOrRejectResponse.fromJson(Map<String, dynamic> json)
      : Result = CommonModel.fromJson(json),
        super.fromJson(json);
}
