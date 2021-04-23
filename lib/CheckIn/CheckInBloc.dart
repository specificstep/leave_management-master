import 'package:flutter_app/CheckIn/CheckInApiResponse.dart';
import 'package:flutter_app/CheckIn/CheckInRepository.dart';
import 'package:flutter_app/CheckIn/CheckInRequest.dart';
import 'package:flutter_app/CheckIn/CheckInResponse.dart';
import 'package:flutter_app/OTP/OTPDoneRequest.dart';
import 'package:flutter_app/OTP/OTPResponse.dart';
import 'package:rxdart/subjects.dart';

class CheckInBloc {
  final CheckInRepository _repository = CheckInRepository();
  final BehaviorSubject<CheckInApiResponse<CheckInResponse>> _subjectCheckin =
      BehaviorSubject<CheckInApiResponse<CheckInResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeCHeckIn(CheckInRequest request) {
    _repository.executeCHeckIn(request, _subjectCheckin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<CheckInApiResponse<CheckInResponse>> get subject => _subjectCheckin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectCheckin.close();
  }
}

///final Object of User Bloc
// final userBloc = UserBloc();
