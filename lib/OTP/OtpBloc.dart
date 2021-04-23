import 'package:flutter_app/OTP/OTPDoneRequest.dart';
import 'package:flutter_app/OTP/OTPResponse.dart';
import 'package:rxdart/rxdart.dart';
import 'OtpApiResponse.dart';
import 'OtpRepository.dart';

class OtpBloc {
  final OtpRepository _repository = OtpRepository();
  final BehaviorSubject<OtpApiResponse<OTPResponse>> _subjectotp =
      BehaviorSubject<OtpApiResponse<OTPResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeOtp(OTPDoneRequest request) {
    _repository.executeOtp(request, _subjectotp);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<OtpApiResponse<OTPResponse>> get subject => _subjectotp;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectotp.close();
  }
}

///final Object of User Bloc
// final userBloc = UserBloc();
