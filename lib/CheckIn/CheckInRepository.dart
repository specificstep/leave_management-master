import 'package:flutter_app/CheckIn/CHeckInCall.dart';
import 'package:flutter_app/CheckIn/CheckInApiResponse.dart';
import 'package:flutter_app/CheckIn/CheckInRequest.dart';
import 'package:flutter_app/CheckIn/CheckInResponse.dart';
import 'package:flutter_app/OTP/OTPCall.dart';
import 'package:flutter_app/OTP/OTPDoneRequest.dart';
import 'package:flutter_app/OTP/OTPResponse.dart';
import 'package:rxdart/rxdart.dart';


class CheckInRepository {

  executeCHeckIn(CheckInRequest request,
      BehaviorSubject<CheckInApiResponse<CheckInResponse>> responseSubject) {
    new CHeckInCall(request, responseSubject).execute();
  }

}
