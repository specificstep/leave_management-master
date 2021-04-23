import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/AllList/AllListCall.dart';
import 'package:flutter_app/Task/AllList/AllListResponse.dart';
import 'package:rxdart/rxdart.dart';

class AllListRepository {
  executeallList(CommonRequest request,
      BehaviorSubject<ApiResponse<AllListResponse>> responseSubject) {
    new AllListCall(request, responseSubject).execute();
  }

}
