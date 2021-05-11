import 'package:flutter_app/Common/CommonModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class KRAManagementResponse extends GeneralResponse {
  CommonModel Result;

  KRAManagementResponse.fromJson(Map<String, dynamic> json)
      : Result = CommonModel.fromJson(json),
        super.fromJson(json);
}
