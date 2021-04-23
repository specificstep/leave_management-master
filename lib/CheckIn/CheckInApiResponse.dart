class CheckInApiResponse<ResultType> {
  Status status;
  ResultType data;
  Error error;

  CheckInApiResponse(Status status, ResultType data, Error error) {
    this.status = status;
    this.data = data;
    this.error = error;
  }

  static CheckInApiResponse loading<ResultType>() {
    return new CheckInApiResponse<ResultType>(Status.LOADING, null, null);
  }

  static CheckInApiResponse success<ResultType>(ResultType data) {
    return new CheckInApiResponse<ResultType>(Status.SUCCESS, data, null);
  }

  static CheckInApiResponse failed<ResultType>(Error error) {
    return new CheckInApiResponse<ResultType>(Status.ERROR, null, error);
  }
}

class Error {
  int statusCode;
  String errorMessage;
  String errorBody;

  Error(this.statusCode, this.errorMessage, this.errorBody);}

enum Status { LOADING, SUCCESS, ERROR }
