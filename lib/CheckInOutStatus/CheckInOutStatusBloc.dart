import 'package:rxdart/rxdart.dart';

import 'CheckInOutStatusApiResponse.dart';
import 'CheckInOutStatusRepository.dart';
import 'CheckInOutStatusRequest.dart';
import 'CheckInOutStatusResponse.dart';


class CheckInOutStatusBloc {
  final CheckInOutStatusRepository _repository = CheckInOutStatusRepository();
  final BehaviorSubject<CheckInOutStatusApiResponse<CheckInOutStatusResponse>> _subjectCheckin =
      BehaviorSubject<CheckInOutStatusApiResponse<CheckInOutStatusResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeCHeckInOutStatus(CheckInOutStatusRequest request) {
    _repository.executeCHeckInOutStatus(request, _subjectCheckin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<CheckInOutStatusApiResponse<CheckInOutStatusResponse>> get subject => _subjectCheckin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectCheckin.close();
  }
}

///final Object of User Bloc
// final userBloc = UserBloc();
