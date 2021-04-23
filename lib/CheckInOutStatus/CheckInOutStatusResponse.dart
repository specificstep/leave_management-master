
import 'package:flutter_app/Login/GeneralResponse.dart';

import 'CheckInOutStatusModel.dart';

class CheckInOutStatusResponse extends GeneralResponse {
  CheckInOutStatusModel checkInOutStatusResponse;

  CheckInOutStatusResponse.fromJson(Map<String, dynamic> json)
      : checkInOutStatusResponse = CheckInOutStatusModel.fromJson(json),
        super.fromJson(json);

}
