class CheckOutApiResponse<ResultType> {
  Status status;
  ResultType data;
  Error error;

  CheckOutApiResponse(Status status, ResultType data, Error error) {
    this.status = status;
    this.data = data;
    this.error = error;
  }

  static CheckOutApiResponse loading<ResultType>() {
    return new CheckOutApiResponse<ResultType>(Status.LOADING, null, null);
  }

  static CheckOutApiResponse success<ResultType>(ResultType data) {
    return new CheckOutApiResponse<ResultType>(Status.SUCCESS, data, null);
  }

  static CheckOutApiResponse failed<ResultType>(Error error) {
    return new CheckOutApiResponse<ResultType>(Status.ERROR, null, error);
  }
}

class Error {
  int statusCode;
  String errorMessage;
  String errorBody;

  Error(this.statusCode, this.errorMessage, this.errorBody);}

enum Status { LOADING, SUCCESS, ERROR }
