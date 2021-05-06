import 'package:flutter_app/Login/GeneralResponse.dart';

import 'ViewTaskModel.dart';

class ViewTaskResponse extends GeneralResponse {
  ViewTaskModel Result;

  ViewTaskResponse.fromJson(Map<String, dynamic> json)
      : Result = ViewTaskModel.fromJson(json),
        super.fromJson(json);

}
