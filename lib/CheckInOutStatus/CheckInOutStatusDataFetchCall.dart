import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import 'CheckInOutStatusApiResponse.dart';

abstract class CheckInOutStatusDataFetchCall<ResultType> {
  bool shouldFetchFromDB();

  void loadFromDB();

  Future<Response> createApiAsync();

  void onSuccess(ResultType response);

  ResultType parseJson(Response response);

  BehaviorSubject<CheckInOutStatusApiResponse<ResultType>> observable;

  CheckInOutStatusDataFetchCall(BehaviorSubject<CheckInOutStatusApiResponse<ResultType>> observable) {
    this.observable = observable;
  }

  void execute() {
    if (shouldFetchFromDB()) {
      loadFromDB();
    } else {
      observable.sink.add(CheckInOutStatusApiResponse.loading<ResultType>());
      _getResponse().then((onValue) {
        observable.sink.add(onValue);
      });
    }
  }

  Future<CheckInOutStatusApiResponse<ResultType>> _getResponse() async {
    try {
      Response response = await createApiAsync();
      print("Response : ${response.data}");
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        ResultType responseModel = parseJson(response);
        onSuccess(responseModel);
        return CheckInOutStatusApiResponse.success<ResultType>(responseModel);
      } else {
        return CheckInOutStatusApiResponse.failed<ResultType>(Error(response.statusCode,
            response.data.toString(), response.data.toString()));
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CheckInOutStatusApiResponse.failed<ResultType>(
          Error(500, error.toString(), stacktrace.toString()));
    }
  }
}
