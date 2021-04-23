import 'package:flutter_app/OTP/OTPCall.dart';
import 'package:flutter_app/OTP/OTPDoneRequest.dart';
import 'package:flutter_app/OTP/OTPResponse.dart';
import 'package:rxdart/rxdart.dart';
import 'OtpApiResponse.dart';


class OtpRepository {

  executeOtp(OTPDoneRequest request,
      BehaviorSubject<OtpApiResponse<OTPResponse>> responseSubject) {
    new OTPCall(request, responseSubject).execute();
  }

}
