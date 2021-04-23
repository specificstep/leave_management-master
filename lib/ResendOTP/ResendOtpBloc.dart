import 'package:flutter_app/ResendOTP/ResendOTPRequest.dart';
import 'package:rxdart/rxdart.dart';

import 'ResendOTPResponse.dart';
import 'ResendOtpApiResponse.dart';
import 'ResendOtpRepository.dart';


class ResendOtpBloc {
  final ResendOtpRepository _repository = ResendOtpRepository();
  final BehaviorSubject<ResendOtpApiResponse<ResendOTPResponse>> _subjectresendotp =
      BehaviorSubject<ResendOtpApiResponse<ResendOTPResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeResendOtp(ResendOTPRequest request) {
    _repository.executeResendOtp(request, _subjectresendotp);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ResendOtpApiResponse<ResendOTPResponse>> get subject => _subjectresendotp;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectresendotp.close();
  }
}

///final Object of User Bloc
// final userBloc = UserBloc();
