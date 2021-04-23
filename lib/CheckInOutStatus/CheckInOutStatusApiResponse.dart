class CheckInOutStatusApiResponse<ResultType> {
  Status status;
  ResultType data;
  Error error;

  CheckInOutStatusApiResponse(Status status, ResultType data, Error error) {
    this.status = status;
    this.data = data;
    this.error = error;
  }

  static CheckInOutStatusApiResponse loading<ResultType>() {
    return new CheckInOutStatusApiResponse<ResultType>(Status.LOADING, null, null);
  }

  static CheckInOutStatusApiResponse success<ResultType>(ResultType data) {
    return new CheckInOutStatusApiResponse<ResultType>(Status.SUCCESS, data, null);
  }

  static CheckInOutStatusApiResponse failed<ResultType>(Error error) {
    return new CheckInOutStatusApiResponse<ResultType>(Status.ERROR, null, error);
  }
}

class Error {
  int statusCode;
  String errorMessage;
  String errorBody;

  Error(this.statusCode, this.errorMessage, this.errorBody);}

enum Status { LOADING, SUCCESS, ERROR }
