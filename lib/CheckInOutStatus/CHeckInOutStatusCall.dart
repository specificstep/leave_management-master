import 'package:dio/dio.dart';
import 'package:flutter_app/CheckInOutStatus/CheckInOutStatusRequest.dart';
import 'package:flutter_app/CheckOut/CheckOutResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'CheckInOutStatusApiResponse.dart';
import 'CheckInOutStatusApiService.dart';
import 'CheckInOutStatusDataFetchCall.dart';
import 'CheckInOutStatusResponse.dart';

class CHeckInOutStatusCall extends CheckInOutStatusDataFetchCall<CheckInOutStatusResponse> {
  CheckInOutStatusRequest _request;
  
  CHeckInOutStatusCall(CheckInOutStatusRequest request, BehaviorSubject<CheckInOutStatusApiResponse<CheckInOutStatusResponse>> responseSubject) : super(responseSubject) {this._request = request;}
  
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
    return checkoutapiServiceInstance.checkout(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(CheckInOutStatusResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  CheckInOutStatusResponse parseJson(Response response) {
    return CheckInOutStatusResponse.fromJson(response.data);
  }
}