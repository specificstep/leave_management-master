import 'package:flutter_app/Login/GeneralResponse.dart';
import 'package:flutter_app/Task/AllList/AllListModel.dart';
import 'package:flutter_app/Task/ProjectList/ProjectListShowModel.dart';

class   ProjectListResponse extends GeneralResponse {
  ProjectListShowModel Result;

  ProjectListResponse.fromJson(Map<String, dynamic> json)
      : Result = ProjectListShowModel.fromJson(json),
        super.fromJson(json);
}
