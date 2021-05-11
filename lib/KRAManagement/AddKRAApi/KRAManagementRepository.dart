
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'AddKRACall.dart';
import 'AddKRARequest.dart';
import 'KRAManagementResponse.dart';


class KRAManagementRepository {
  executeAddKRA(AddKRARequest request,
      BehaviorSubject<ApiResponse<KRAManagementResponse>> responseSubject) {
    new AddKRACall(request, responseSubject).execute();
  }

}
