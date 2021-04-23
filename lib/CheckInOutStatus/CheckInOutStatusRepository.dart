import 'package:rxdart/rxdart.dart';

import 'CHeckInOutStatusCall.dart';
import 'CheckInOutStatusApiResponse.dart';
import 'CheckInOutStatusRequest.dart';
import 'CheckInOutStatusResponse.dart';



class CheckInOutStatusRepository {

  executeCHeckInOutStatus(CheckInOutStatusRequest request,
      BehaviorSubject<CheckInOutStatusApiResponse<CheckInOutStatusResponse>> responseSubject) {
    new CHeckInOutStatusCall(request, responseSubject).execute();
  }

}
