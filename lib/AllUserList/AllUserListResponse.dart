import 'package:flutter_app/Login/GeneralResponse.dart';

import 'AllUserListModel.dart';

class AllUserListResponse extends GeneralResponse {
  AllUserListModel Result;

  AllUserListResponse.fromJson(Map<String, dynamic> json)
      : Result = AllUserListModel.fromJson(json),
        super.fromJson(json);
}
