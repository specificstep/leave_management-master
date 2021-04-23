import 'package:dio/dio.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

abstract class LeaveListDataFetchCall<ResultType> {
  bool shouldFetchFromDB();

  void loadFromDB();

  Future<Response> createApiAsync();

  void onSuccess(ResultType response);

  ResultType parseJson(Response response);

  BehaviorSubject<ApiResponse<ResultType>> observable;

  LeaveListDataFetchCall(BehaviorSubject<ApiResponse<ResultType>> observable) {
    this.observable = observable;
  }

  void execute() {
    if (shouldFetchFromDB()) {
      loadFromDB();
    } else {
      observable.sink.add(ApiResponse.loading<ResultType>());
      _getResponse().then((onValue) {
        observable.sink.add(onValue);
      });
    }
  }

  Future<ApiResponse<ResultType>> _getResponse() async {
    try {
      Response response = await createApiAsync();
      print("Response : ${response.data}");
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        ResultType responseModel = parseJson(response);
        onSuccess(responseModel);
        return ApiResponse.success<ResultType>(responseModel);
      } else {
        return ApiResponse.failed<ResultType>(Error(response.statusCode,
            response.data.toString(), response.data.toString()));
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ApiResponse.failed<ResultType>(
          Error(500, error.toString(), stacktrace.toString()));
    }
  }
}
