import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/AllList/AllListCall.dart';
import 'package:flutter_app/Task/AllList/AllListResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'AllListRequest.dart';

class AllListRepository {
  executeallList(AllListRequest request,
      BehaviorSubject<ApiResponse<AllListResponse>> responseSubject) {
    new AllListCall(request, responseSubject).execute();
  }

}
