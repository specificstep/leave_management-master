import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'CheckOutApiResponse.dart';


abstract class CheckOutDataFetchCall<ResultType> {
  bool shouldFetchFromDB();

  void loadFromDB();

  Future<Response> createApiAsync();

  void onSuccess(ResultType response);

  ResultType parseJson(Response response);

  BehaviorSubject<CheckOutApiResponse<ResultType>> observable;

  CheckOutDataFetchCall(BehaviorSubject<CheckOutApiResponse<ResultType>> observable) {
    this.observable = observable;
  }

  void execute() {
    if (shouldFetchFromDB()) {
      loadFromDB();
    } else {
      observable.sink.add(CheckOutApiResponse.loading<ResultType>());
      _getResponse().then((onValue) {
        observable.sink.add(onValue);
      });
    }
  }

  Future<CheckOutApiResponse<ResultType>> _getResponse() async {
    try {
      Response response = await createApiAsync();
      print("Response : ${response.data}");
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        ResultType responseModel = parseJson(response);
        onSuccess(responseModel);
        return CheckOutApiResponse.success<ResultType>(responseModel);
      } else {
        return CheckOutApiResponse.failed<ResultType>(Error(response.statusCode,
            response.data.toString(), response.data.toString()));
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CheckOutApiResponse.failed<ResultType>(
          Error(500, error.toString(), stacktrace.toString()));
    }
  }
}
