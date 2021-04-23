import 'package:dio/dio.dart';
import 'package:flutter_app/CheckIn/CheckInApiResponse.dart';
import 'package:rxdart/rxdart.dart';


abstract class CheckInDataFetchCall<ResultType> {
  bool shouldFetchFromDB();

  void loadFromDB();

  Future<Response> createApiAsync();

  void onSuccess(ResultType response);

  ResultType parseJson(Response response);

  BehaviorSubject<CheckInApiResponse<ResultType>> observable;

  CheckInDataFetchCall(BehaviorSubject<CheckInApiResponse<ResultType>> observable) {
    this.observable = observable;
  }

  void execute() {
    if (shouldFetchFromDB()) {
      loadFromDB();
    } else {
      observable.sink.add(CheckInApiResponse.loading<ResultType>());
      _getResponse().then((onValue) {
        observable.sink.add(onValue);
      });
    }
  }

  Future<CheckInApiResponse<ResultType>> _getResponse() async {
    try {
      Response response = await createApiAsync();
      print("Response : ${response.data}");
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        ResultType responseModel = parseJson(response);
        onSuccess(responseModel);
        return CheckInApiResponse.success<ResultType>(responseModel);
      } else {
        return CheckInApiResponse.failed<ResultType>(Error(response.statusCode,
            response.data.toString(), response.data.toString()));
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CheckInApiResponse.failed<ResultType>(
          Error(500, error.toString(), stacktrace.toString()));
    }
  }
}
