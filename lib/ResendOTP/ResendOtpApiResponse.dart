class ResendOtpApiResponse<ResultType> {
  Status status;
  ResultType data;
  Error error;

  ResendOtpApiResponse(Status status, ResultType data, Error error) {
    this.status = status;
    this.data = data;
    this.error = error;
  }

  static ResendOtpApiResponse loading<ResultType>() {
    return new ResendOtpApiResponse<ResultType>(Status.LOADING, null, null);
  }

  static ResendOtpApiResponse success<ResultType>(ResultType data) {
    return new ResendOtpApiResponse<ResultType>(Status.SUCCESS, data, null);
  }

  static ResendOtpApiResponse failed<ResultType>(Error error) {
    return new ResendOtpApiResponse<ResultType>(Status.ERROR, null, error);
  }
}

class Error {
  int statusCode;
  String errorMessage;
  String errorBody;

  Error(this.statusCode, this.errorMessage, this.errorBody);}

enum Status { LOADING, SUCCESS, ERROR }
