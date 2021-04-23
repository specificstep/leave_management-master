
import 'package:flutter_app/Login/GeneralResponse.dart';

import 'CheckInModel.dart';

class CheckInResponse extends GeneralResponse {
  CheckInModel inModel;

  CheckInResponse.fromJson(Map<String, dynamic> json)
      : inModel = CheckInModel.fromJson(json),
        super.fromJson(json);

}
