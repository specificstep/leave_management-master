import 'package:flutter_app/BithdayList/BirthdayListCall.dart';
import 'package:flutter_app/BithdayList/BirthdayListResponse.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class BirthdayListRepository {
  executeBirthdayList(CommonRequest request,
      BehaviorSubject<ApiResponse<BirthdayListResponse>> responseSubject) {
    new BirthdayListCall(request, responseSubject).execute();
  }

}
