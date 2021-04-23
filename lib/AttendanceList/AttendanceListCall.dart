import 'package:dio/dio.dart';
import 'package:flutter_app/AttendanceList/AttendanceListApiService.dart';
import 'package:flutter_app/AttendanceList/AttendanceListRequest.dart';
import 'package:flutter_app/AttendanceList/AttendanceListResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

class AttendanceListCall extends DataFetchCall<AttendanceListResponse> {
  AttendanceListRequest  _request;
  AttendanceListCall(AttendanceListRequest  request,
      BehaviorSubject<ApiResponse<AttendanceListResponse>> responseSubject)
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
    return atendanceapiServiceInstance.attendancelist(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(AttendanceListResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  AttendanceListResponse parseJson(Response response) {
    return AttendanceListResponse.fromJson(response.data);
  }
}
