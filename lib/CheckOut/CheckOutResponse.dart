import 'package:flutter_app/CheckIn/CheckInModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class CheckOutResponse extends GeneralResponse {
  CheckInModel inModel;

  CheckOutResponse.fromJson(Map<String, dynamic> json)
      : inModel = CheckInModel.fromJson(json),
        super.fromJson(json);

}
