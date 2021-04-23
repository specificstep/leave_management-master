import 'package:dio/dio.dart';
import 'package:flutter_app/BithdayList/BirthdayListResponse.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

import 'BirthdayListApiService.dart';

class BirthdayListCall extends DataFetchCall<BirthdayListResponse> {
  CommonRequest  _request;
  BirthdayListCall(CommonRequest  request,
      BehaviorSubject<ApiResponse<BirthdayListResponse>> responseSubject)
      : super(responseSubject) {
    this._request = request;
  }

  /// if return false then createApiAsyc is called
  /// if return true then loadFromDB Function  is called
  @override
  bool shouldFetchFromDB() {
    return false;
  }

  /// called when shouldFetchfromDB() is returning true
  @override
  void loadFromDB() {
    ///  get data from DB todo post/sinc on behaviourSubject after
  }

  /// called when shouldFetchfromDB() is returning false

  @override
  Future<Response> createApiAsync() {
    /// need to return APIService async task for API request
    return apiServiceInstance.birthdaylist(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(BirthdayListResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  BirthdayListResponse parseJson(Response response) {
    return BirthdayListResponse.fromJson(response.data);
  }
}
