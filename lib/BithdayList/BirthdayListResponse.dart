import 'package:flutter_app/BithdayList/BirthdayListModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class   BirthdayListResponse extends GeneralResponse {
  BirthdayListModel Result;

  BirthdayListResponse.fromJson(Map<String, dynamic> json)
      : Result = BirthdayListModel.fromJson(json),
        super.fromJson(json);
}
