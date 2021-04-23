import 'package:flutter_app/Login/GeneralResponse.dart';
import 'package:flutter_app/Task/AllList/AllListModel.dart';

class   AllListResponse extends GeneralResponse {
  AllListModel Result;

  AllListResponse.fromJson(Map<String, dynamic> json)
      : Result = AllListModel.fromJson(json),
        super.fromJson(json);
}
