import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/KRAManagement/KRAEmployeeList/KRAEmployeeListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'KRAEmployeeListCall.dart';



class KRAEmployeeListRepository {
  executekraemployeeList(CommonRequest request,
      BehaviorSubject<ApiResponse<KRAEmployeeListResponse>> responseSubject) {
    new KRAEmployeeListCall(request, responseSubject).execute();
  }

}
