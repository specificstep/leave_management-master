import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import 'ResendOtpApiResponse.dart';

abstract class ResendOtpDataFetchCall<ResultType> {
  bool shouldFetchFromDB();

  void loadFromDB();

  Future<Response> createApiAsync();

  void onSuccess(ResultType response);

  ResultType parseJson(Response response);

  BehaviorSubject<ResendOtpApiResponse<ResultType>> observable;

  ResendOtpDataFetchCall(BehaviorSubject<ResendOtpApiResponse<ResultType>> observable) {
    this.observable = observable;
  }

  void execute() {
    if (shouldFetchFromDB()) {
      loadFromDB();
    } else {
      observable.sink.add(ResendOtpApiResponse.loading<ResultType>());
      _getResponse().then((onValue) {
        observable.sink.add(onValue);
      });
    }
  }

  Future<ResendOtpApiResponse<ResultType>> _getResponse() async {
    try {
      Response response = await createApiAsync();
      print("Response : ${response.data}");
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        ResultType responseModel = parseJson(response);
        onSuccess(responseModel);
        return ResendOtpApiResponse.success<ResultType>(responseModel);
      } else {
        return ResendOtpApiResponse.failed<ResultType>(Error(response.statusCode,
            response.data.toString(), response.data.toString()));
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResendOtpApiResponse.failed<ResultType>(
          Error(500, error.toString(), stacktrace.toString()));
    }
  }
}
