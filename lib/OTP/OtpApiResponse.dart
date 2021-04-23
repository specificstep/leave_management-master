class OtpApiResponse<ResultType> {
  Status status;
  ResultType data;
  Error error;

  OtpApiResponse(Status status, ResultType data, Error error) {
    this.status = status;
    this.data = data;
    this.error = error;
  }

  static OtpApiResponse loading<ResultType>() {
    return new OtpApiResponse<ResultType>(Status.LOADING, null, null);
  }

  static OtpApiResponse success<ResultType>(ResultType data) {
    return new OtpApiResponse<ResultType>(Status.SUCCESS, data, null);
  }

  static OtpApiResponse failed<ResultType>(Error error) {
    return new OtpApiResponse<ResultType>(Status.ERROR, null, error);
  }
}

class Error {
  int statusCode;
  String errorMessage;
  String errorBody;

  Error(this.statusCode, this.errorMessage, this.errorBody);}

enum Status { LOADING, SUCCESS, ERROR }
