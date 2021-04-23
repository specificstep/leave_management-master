import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import 'CheckOutApiResponse.dart';
import 'CheckOutApiService.dart';
import 'CheckOutDataFetchCall.dart';
import 'CheckOutRequest.dart';
import 'CheckOutResponse.dart';



class CHeckOutCall extends CheckOutDataFetchCall<CheckOutResponse> {
  CheckOutRequest _request;
  
  CHeckOutCall(CheckOutRequest request, BehaviorSubject<CheckOutApiResponse<CheckOutResponse>> responseSubject) : super(responseSubject) {this._request = request;}
  
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
  void onSuccess(CheckOutResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  CheckOutResponse parseJson(Response response) {
    return CheckOutResponse.fromJson(response.data);
  }
}