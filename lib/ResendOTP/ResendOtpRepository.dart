import 'package:flutter_app/OTP/OTPDoneRequest.dart';
import 'package:flutter_app/ResendOTP/ResendOTPRequest.dart';
import 'package:rxdart/rxdart.dart';
import 'ResendOTPCall.dart';
import 'ResendOTPResponse.dart';
import 'ResendOtpApiResponse.dart';


class ResendOtpRepository {

  executeResendOtp(ResendOTPRequest request,
      BehaviorSubject<ResendOtpApiResponse<ResendOTPResponse>> responseSubject) {
    new ResendOTPCall(request, responseSubject).execute();
  }

}
